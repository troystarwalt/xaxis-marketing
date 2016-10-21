class Video < ApplicationRecord
  include ActiveAdmin::Callbacks
  define_active_admin_callbacks :save
  belongs_to :platform
  # before_save :get_image_preview
  validates_presence_of :name, :direct_link, :platform_id
  mount_uploader :remote_image_preview_url, VideoPreviewUploader

  private

  # def get_image_preview
  #   preview = VideoThumb::get(@video.direct_link)
  #   @video.remote_image_preview_url = preview
  # end
end
