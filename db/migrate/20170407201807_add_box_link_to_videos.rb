class AddBoxLinkToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :box_download_link, :string
  end
end
