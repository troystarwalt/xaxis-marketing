class AddVimeoIdToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :vimeo_video_id, :string
  end
end
