class AddColorImageToHeadshotsAndRenameImagesToGreyImage < ActiveRecord::Migration[5.0]
  def change
    rename_column :headshots, :image, :grey_image
    add_column :headshots, :color_image, :string
  end
end
