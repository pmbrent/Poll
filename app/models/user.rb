class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )

  def completed_polls

    Poll.find_by_sql([<<-SQL, self.id])
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions
      AS qs
      ON qs.poll_id = polls.id
      JOIN
        answer_choices
      AS ac
      ON qs.id = ac.question_id
      LEFT OUTER JOIN(
        SELECT
          responses.*
        FROM
          responses
        WHERE
          responses.user_id = ?
      ) AS ur
      ON ur.answer_id = ac.id
      GROUP BY
        polls.id
      HAVING
        COUNT(distinct qs.*) = COUNT(ur.*)
    SQL

  end


end
