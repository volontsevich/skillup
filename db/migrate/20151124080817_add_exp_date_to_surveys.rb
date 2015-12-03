class AddExpDateToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :exp_date, :date
  end
end
