class Document < ApplicationRecord
  belongs_to :user
  has_many :comments

  alias_attribute :parent, :folder 

  have_one :container, dependant: :destroy
  have_one :folder, through: :container

  def set_parent(parent_folder_id)
    if parent_folder_id
      parent = Folder.find(parent_folder_id)
      parent.documents << self
      "#{filename} was added to #{parent.name}"
    else
      "#{filename} was added"
    end
  end

  def parent
    Folder.joins(:containers).where("containers.containable_id = ? and containers.containable_type = ?", "#{self.id}", 'Document').first
  end

  def amazon_path
    "#{parent.user_id}/#{parent.id}"
  end

end
