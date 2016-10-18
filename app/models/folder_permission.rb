class FolderPermission < ApplicationRecord
  belongs_to :user
  belongs_to :folder
end
