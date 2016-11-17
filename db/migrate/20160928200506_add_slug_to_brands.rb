# frozen_string_literal: true
class AddSlugToBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :slug, :string
    add_index :brands, :slug, unique: true
  end
end
