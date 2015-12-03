class AddOptionToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :option, :integer
  end
end
