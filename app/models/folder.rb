class Folder < ApplicationRecord
  belongs_to :user
  # belongs_to :folder, optional: true
  has_many :containers
  has_many :subfolders, through: :containers, source: :containable, source_type: 'Folder'
  has_many :documents, through: :containers, source: :containable, source_type: 'Document'
end
