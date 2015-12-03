class AddMetaToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :meta, :string
  end
end
