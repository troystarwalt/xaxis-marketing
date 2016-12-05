class CreateOneOhOnes < ActiveRecord::Migration[5.0]
  def change
    create_table :one_oh_ones do |t|
      t.string :name
      t.string :pdf_file
      t.string :ppt_file
      t.string :preview_image

      t.timestamps
    end
  end
end
