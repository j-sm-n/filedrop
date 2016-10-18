class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :filename
      t.string :content_type
      t.binary :data
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
