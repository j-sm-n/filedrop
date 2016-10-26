class ExternalApplication < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :api_key, presence: true, uniqueness: true
end
