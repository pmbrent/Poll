class Response < ActiveRecord::Base

  validates :answer_id, presence: true
  validates :user_id, presence: true

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses

    self.question.responses.where(responses.id != self.id)

  end

end
