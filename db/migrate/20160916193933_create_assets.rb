class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.references :brand, foreign_key: true
      t.references :logo, foreign_key: true

      t.timestamps
    end
  end
end
