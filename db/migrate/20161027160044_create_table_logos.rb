class CreateTableLogos < ActiveRecord::Migration[5.0]
  def change
    create_table :logos do |t|
      t.string :name
      t.string :file
      t.string :content_type
      t.integer :file_size
      t.references :platform, foreign_key: true
      t.timestamps
    end
  end
end
