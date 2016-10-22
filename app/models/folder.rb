class Folder < ApplicationRecord
  belongs_to :user
  # belongs_to :container, foreign_key: :containable, optional: true
  # belongs_to :folder, optional: true
  has_many :containers
  has_many :subfolders, through: :containers, source: :containable, source_type: 'Folder'
  has_many :documents, through: :containers, source: :containable, source_type: 'Document'

  def parent #the id of folder selected in dropdown
    Folder.joins(:containers).where("containers.containable_id" => self.id)
    # Folder.where(folder_id coming from params equals Container.find(containable_id = folder.id)
  end

  # Container.where(containable_id: 2).select(:folder_id)
end
