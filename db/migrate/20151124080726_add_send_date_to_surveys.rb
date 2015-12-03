class AddSendDateToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :send_date, :date
  end
end
