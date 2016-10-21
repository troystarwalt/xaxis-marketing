class Video < ApplicationRecord
  # include ActiveAdmin::Callbacks
  # define_active_admin_callbacks :save
  belongs_to :platform
  before_save :get_image_preview
  validates_presence_of :name, :direct_link, :platform_id
  mount_uploader :image_preview, VideoPreviewUploader

  private

  def get_image_preview
    preview = VideoThumb::get(self.direct_link)
    self.image_preview = open(preview)
  end
end
