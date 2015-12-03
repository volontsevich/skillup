class CreateSurveyMails < ActiveRecord::Migration
  def change
    create_table :survey_mails do |t|
      t.references :survey, index: true, foreign_key: true
      t.string :address

      t.timestamps null: false
    end
  end
end
