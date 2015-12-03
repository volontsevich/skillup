class Question < ActiveRecord::Base
  belongs_to :survey

  has_many :responds, dependent: :destroy
  validates_presence_of :content

end
