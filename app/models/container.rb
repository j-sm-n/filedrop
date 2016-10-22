class Container < ApplicationRecord
  belongs_to :folder

  has_many :containables, polymorphic: true
  has_many :folders, through: :containables
  has_many :files, through: :containables
end
