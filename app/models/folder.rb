class Folder < ApplicationRecord
  belongs_to :user
  # belongs_to :container, foreign_key: :containable, optional: true
  # belongs_to :folder, optional: true
  has_many :containers
  has_many :subfolders, through: :containers, source: :containable, source_type: 'Folder'
  has_many :documents, through: :containers, source: :containable, source_type: 'Document'

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
    Folder.joins(:containers).where("containers.containable_id" => self.id)
  end
end
