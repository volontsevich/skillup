class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :responds, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :survey_mails, dependent: :destroy
  validates_presence_of :name
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: lambda {|attributes| attributes['content'].blank?}
end