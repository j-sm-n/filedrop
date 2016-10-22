class User < ApplicationRecord
  has_secure_password

  validates :email,  presence: true, format: { with: /\A.+@.+$\Z/ }, uniqueness: true
  validates :name, presence: true
  validates :sms_number, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_many :folders
  def verify(token)
    TwilioService.new(self).verify(token)
  end
end
