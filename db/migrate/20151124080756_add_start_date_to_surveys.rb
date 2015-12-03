class AddStartDateToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :start_date, :date
  end
end
