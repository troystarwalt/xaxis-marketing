# frozen_string_literal: true
class CreatePlatforms < ActiveRecord::Migration[5.0]
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :platforms, :slug, unique: true
  end
end
