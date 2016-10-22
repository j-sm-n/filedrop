class Folder < ApplicationRecord
  belongs_to :user
  # belongs_to :container, foreign_key: :containable, optional: true
  # belongs_to :folder, optional: true
  has_many :containers
  has_many :subfolders, through: :containers, source: :containable, source_type: 'Folder'
  has_many :documents, through: :containers, source: :containable, source_type: 'Document'

  enum permission_level: %w(restricted unrestricted)
  
  def parent #the id of folder selected in dropdown
    Folder.joins(:containers).where("containers.containable_id" => self.id)
  end
end
