class AddPermissionLevelToFolder < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :permission_level, :integer
  end
end
