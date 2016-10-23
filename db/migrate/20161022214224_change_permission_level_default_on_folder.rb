class ChangePermissionLevelDefaultOnFolder < ActiveRecord::Migration[5.0]
  def change
    change_column_default :folders, :permission_level, 0
  end
end
