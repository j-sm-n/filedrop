class User < ApplicationRecord
  has_secure_password
  after_create :root_folder

  scope :non_admin_users, -> { where(role: 'user') }

  validates :email,  presence: true, format: { with: /\A.+@.+$\Z/ }, uniqueness: true
  validates :name, presence: true
  validates :sms_number, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_many :folders
  has_many :folder_permissions
  # has_many :allowed_folders, through: :folder_permissions
  enum status: { active: 0, deactivated: 1 }
  enum role: { user: 0, admin: 1 }

  def create_authy_user
    service = TwilioService.new(self)
    response = service.get_authy_user
    if response[:success]
      update_attribute(:authy_id, response[:user][:id])
    else
      return false
    end
    save
  end

  def verify(token)
    TwilioService.new(self).verify(token)
  end

  def toggle_status?
    if active?
      update_attribute(:status, :deactivated)
    elsif deactivated?
      update_attribute(:status, :active)
    else
      false
    end
  end

  def root_folder
    folders.create(name: "#{name}'s Stuff")
  end
end
