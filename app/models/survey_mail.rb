class SurveyMail < ActiveRecord::Base
  belongs_to :survey
  validates_presence_of :address
  scope :for_survey, ->(id) { where(survey_id: id) }
end
