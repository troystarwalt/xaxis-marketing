class CreateBrandAccessories < ActiveRecord::Migration[5.0]
  def change
    create_table :brand_accessories do |t|
      t.string :name
      t.string :file
      t.string :category
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
