class CreateContainers < ActiveRecord::Migration[5.0]
  def change
    create_table :containers do |t|
      t.references :folder, foreign_key: true
      t.integer :containable_id
      t.string :containable_type

      t.timestamps
    end
  end
end
