class Document < ApplicationRecord
  before_destroy :remove_from_storage
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_one :container, as: :containable
  has_one :folder, through: :container, dependent: :destroy
  alias_attribute :parent, :folder


  alias_attribute :parent, :folder

  has_one :container, as: :containable, dependent: :destroy
  has_one :folder, through: :container

  def set_parent(parent_folder_id)
    if parent_folder_id
      parent = Folder.find(parent_folder_id)
      parent.documents << self
      "#{filename} was added to #{parent.name}"
    else
      "#{filename} was added"
    end
  end

  # def parent
  #   Folder.joins(:containers).where("containers.containable_id = ? and containers.containable_type = ?", "#{self.id}", 'Document').first
  # end

  def amazon_path
    "#{parent.user_id}/#{parent.id}"
  end

  def remove_from_storage
  #   bucket = ENV['S3_BUCKET']
  #   bucket.object(amazon_path+"/#{filename}").delete
  end
end
