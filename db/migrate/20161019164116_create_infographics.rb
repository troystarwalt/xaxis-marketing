class CreateInfographics < ActiveRecord::Migration[5.0]
  def change
    create_table :infographics do |t|
      t.string :name
      t.string :description
      t.string :image_preview
      t.string :file
      t.references :platform, foreign_key: true

      t.timestamps
    end
  end
end
