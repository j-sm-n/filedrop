class Comment < ApplicationRecord
  belongs_to :document
  belongs_to :user

  validates :content, presence: true
end
