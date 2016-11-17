# frozen_string_literal: true
class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :description
      t.string :direct_link
      t.text :embed_link
      t.string :image_preview
      t.references :platform, foreign_key: true

      t.timestamps
    end
  end
end
