class Document < ApplicationRecord
  belongs_to :user

  def set_parent(parent_folder_id)
    if parent_folder_id
      parent = Folder.find(parent_folder_id)
      parent.documents << self
      "#{filename} was added to #{parent.name}"
    else
      "#{filename} was added"
    end
  end

  def parent #the id of folder selected in dropdown
    Folder.joins(:containers).where("containers.containable_id = ? and containers.containable_type = ?", "#{self.id}", 'Document').first
  end

  def amazon_path
    "#{parent.user_id}/#{parent.id}"
  end

end
