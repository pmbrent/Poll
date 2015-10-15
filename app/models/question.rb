class Question < ActiveRecord::Base

  validates :poll_id, presence: true

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results_n_plus_one
    answers = answer_choices
    results = {}
    answers.each do |choice|
      results[choice.answer] = choice.responses.count
    end
    results
  end

  def results_with_includes
    answers = answer_choices.includes(:responses)
    results = {}
    answers.each do |choice|
      results[choice.answer] = choice.responses.length
    end
    results
  end

  def results_sql
    sql_returns = AnswerChoice.find_by_sql([<<-SQL, self.id])
      SELECT
        answer_choices.*, COUNT(answer_responses.*) AS response_count
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses AS answer_responses
        ON answer_responses.answer_id = answer_choices.id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id
    SQL

    results = {}

    sql_returns.each do |answer|
      results[answer.answer] = answer.response_count
    end

    results
  end

  def results
    join_str = <<-SQL
              LEFT OUTER JOIN responses
                ON responses.answer_id = answer_choices.id
              SQL

    answers = answer_choices
              .select("answer_choices.*, count(responses.*) AS response_count")
              .joins(join_str)
              .group("answer_choices.id")


    results = {}

    answers.each do |answer|
      results[answer.answer] = answer.response_count
    end

    results
  end

end
