class AddPreviewImageToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :preview_image, :string
  end
end
