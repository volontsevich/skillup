class SurveyMail < ActiveRecord::Base
  belongs_to :survey
  validates_presence_of :address
end
