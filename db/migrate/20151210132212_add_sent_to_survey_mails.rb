class AddSentToSurveyMails < ActiveRecord::Migration
  def change
    add_column :survey_mails, :sent, :boolean
  end
end
