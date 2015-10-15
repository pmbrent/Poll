class Response < ActiveRecord::Base

  validates :answer_id, presence: true
  validates :user_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_author

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
    # responses.where.not(id: self.id)
    where_str = self.persisted? ? "responses.id != ?" : "responses.id IS NOT NULL"
    self.question.responses.where(where_str, self.id)
  end

private
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors.add(:response, "user already answered this question")
    end
  end

  def respondent_is_not_author
    if self.answer_choice.question.poll.author_id == self.user_id
      errors.add(:response, "respondent is the author!")
    end
  end

end
