class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :one_oh_ones, :preview_image, :image_preview
  end
end
