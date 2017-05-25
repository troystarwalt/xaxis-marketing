class RemoveVideosIndexFromPlatforms < ActiveRecord::Migration[5.0]
  def change
    remove_column :videos, :platform_id
  end
end
