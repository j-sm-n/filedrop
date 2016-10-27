class Folder < ApplicationRecord
  belongs_to :user
  scope :unrestricted_folders, -> { where(permission_level: 'unrestricted') }

  has_many :containers, dependent: :destroy
  has_many :subfolders, through: :containers, source: :containable, source_type: 'Folder', dependent: :destroy
  has_many :documents, through: :containers, source: :containable, source_type: 'Document', dependent: :destroy

  alias_attribute :authorized_users, :users
  has_many :folder_permissions
  has_many :users, through: :folder_permissions

  alias_attribute :parent, :folder
  has_one :container, as: :containable
  has_one :folder, through: :container

  enum permission_level: %w(restricted unrestricted)

  def set_parent(parent_folder_id)
    if parent_folder_id
      parent = Folder.find(parent_folder_id)
      parent.subfolders << self
      "#{name} was added to #{parent.name}"
    else
      "#{name} was added"
    end
  end

  def accessible?(visitor)
    if user.active? && visitor
      unrestricted? || authorized_users.include?(visitor) || visitor.admin? || visitor == user
    elsif user.active?
      unrestricted?
    else
      return false
    end
  end
end
