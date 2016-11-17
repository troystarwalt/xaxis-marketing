# frozen_string_literal: true
class CreateGlobalAccessories < ActiveRecord::Migration[5.0]
  def change
    create_table :global_accessories do |t|
      t.string :name
      t.string :category
      t.string :file

      t.timestamps
    end
  end
end
