class ChangeQuestionToText < ActiveRecord::Migration
  def change

    change_column :questions, :question, :text

  end
end
