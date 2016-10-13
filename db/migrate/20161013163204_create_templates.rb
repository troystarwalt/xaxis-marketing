class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string :name
      t.string :type
      t.string :file
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
