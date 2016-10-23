class Document < ApplicationRecord
  belongs_to :user

  #to do, add reciprocal relationship
  # belongs_to :container
  #
  # belongs_to :folder, through: :container
end
