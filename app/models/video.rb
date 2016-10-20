class Video < ApplicationRecord
  belongs_to :platform
  before_save :get_image_preview
  validates_presence_of :name, :direct_link, :platform_id
  mount_uploader :image_preview, FileUploader

  private

  def get_image_preview
    preview = VideoThumb::get(self.direct_link)
    self.image_preview = preview
  end
end
