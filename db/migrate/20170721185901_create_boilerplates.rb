class CreateBoilerplates < ActiveRecord::Migration[5.0]
  def change
    create_table :boilerplates do |t|
      t.text :description
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
