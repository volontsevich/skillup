class Respond < ActiveRecord::Base
  belongs_to :survey
  # belongs_to :user
  scope :for_question, ->(id) { where(question_id: id) }
end
