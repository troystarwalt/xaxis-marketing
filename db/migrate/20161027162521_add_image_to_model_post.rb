# frozen_string_literal: true
class AddImageToModelPost < ActiveRecord::Migration[5.0]
  def change
      add_column :posts, :image, :string
  end
end
