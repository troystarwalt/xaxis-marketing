class CreateHeadshots < ActiveRecord::Migration[5.0]
  def change
    create_table :headshots do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.integer :brand_id
      t.string :image

      t.timestamps
    end
  end
end
