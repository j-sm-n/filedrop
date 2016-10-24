class Folder < ApplicationRecord
  belongs_to :user
  scope :unrestricted_folders, -> { where(permission_level: 'unrestricted') }

  has_many :containers
  has_many :subfolders, through: :containers, source: :containable, source_type: 'Folder'
  has_many :documents, through: :containers, source: :containable, source_type: 'Document'

  alias_attribute :authorized_users, :users
  has_many :folder_permissions
  has_many :users, through: :folder_permissions


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

  def parent #the id of folder selected in dropdown
    #Folder.joins(:containers).where("containers.containable_id = 2 and containers.containable_type = 'Folder'")
    Folder.joins(:containers).where("containers.containable_id = ? and containers.containable_type = ?", "#{self.id}", 'Folder')
  end

  def accessible?(visitor)
    if user.active?
      unrestricted? || authorized_users.include?(visitor) || visitor == user
    else
      return false
    end
  end
end
