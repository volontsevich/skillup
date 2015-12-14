class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :surveys, dependent: :destroy
  # has_many :responds, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :send_notification
  private
  def send_notification
    UserMailer.new_user(self).deliver_now
  end

end
