# frozen_string_literal: true
class AddRemoteImagePreviewUrlToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :remote_image_preview_url, :string
  end
end
