class CreateOneSheeters < ActiveRecord::Migration[5.0]
  def change
    create_table :one_sheeters do |t|
      t.string :name
      t.string :file
      t.references :platform, foreign_key: true

      t.timestamps
    end
  end
end
