class CreateExternalApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :external_applications do |t|
      t.string :name
      t.string :email
      t.string :api_key
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
