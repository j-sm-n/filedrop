class RemoveEmailFromExternalApplicatio < ActiveRecord::Migration[5.0]
  def change
    remove_column :external_applications, :email
  end
end
