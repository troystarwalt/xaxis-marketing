class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :image
      t.string :description
      t.datetime :taken

      t.timestamps
    end
  end
end
