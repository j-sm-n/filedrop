class RemoveDataFromDocument < ActiveRecord::Migration[5.0]
  def change
    remove_column :documents, :data
  end
end
