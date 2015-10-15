# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(user_name: "Pat")
User.create!(user_name: "Mike")

Poll.create!({title: "Opinion on Something", author_id: 1})
Poll.create!(title: "Pick an Answer", author_id: 2)

Question.create!({poll_id: 1, question: "What do you think about this?"})
Question.create!({poll_id: 1, question: "What do you think about that?"})
Question.create!({poll_id: 2, question: "What should be done?"})
Question.create!({poll_id: 2, question: "Where did you put the thing?"})

AnswerChoice.create!({answer: "Good idea", question_id: 1})
AnswerChoice.create!({answer: "Neutral idea", question_id: 1})
AnswerChoice.create!({answer: "Bad idea", question_id: 1})
AnswerChoice.create!({answer: "Good idea", question_id: 2})
AnswerChoice.create!({answer: "Neutral idea", question_id: 2})
AnswerChoice.create!({answer: "Bad idea", question_id: 2})
AnswerChoice.create!({answer: "Something", question_id: 3})
AnswerChoice.create!({answer: "Nothing", question_id: 3})
AnswerChoice.create!({answer: "About what?", question_id: 3})
AnswerChoice.create!({answer: "Good place", question_id: 4})
AnswerChoice.create!({answer: "Neutral place", question_id: 4})
AnswerChoice.create!({answer: "Bad place", question_id: 4})

Response.create!({answer_id: 1, user_id: 2})
Response.create!({answer_id: 5, user_id: 2})
Response.create!({answer_id: 7, user_id: 1})
Response.create!({answer_id: 10, user_id: 1})
