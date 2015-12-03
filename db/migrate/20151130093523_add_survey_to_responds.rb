class AddSurveyToResponds < ActiveRecord::Migration
  def change
    add_reference :responds, :survey, index: true, foreign_key: true
  end
end
