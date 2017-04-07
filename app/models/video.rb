# frozen_string_literal: true
class Video < ApplicationRecord
  # include ActiveAdmin::Callbacks
  # define_active_admin_callbacks :save
  belongs_to :platform
  belongs_to :brand
  before_validation :get_video_id
  before_validation :get_image_preview
  validates_presence_of :name, :direct_link
  mount_uploader :image_preview, VideoPreviewUploader

  private

  def get_image_preview
    video_link = self.direct_link
    image_preview = self.image_preview
    if image_preview.blank?
      if accessible?(video_link)
        preview = VideoThumb::get(self.direct_link)
        self.image_preview = open(preview)
      else
        puts "You'll need to upload your own image."
      end
    end
  end

  def get_video_id
    url = self.direct_link
    find_video_id(url)
  end

  def find_video_id(url_of_video)
    try_match = /vimeo.com\/?(.+([^\D\s]))/
    matched_id = try_match.match(url_of_video)
    if matched_id[1].present?
      self.vimeo_video_id = matched_id[1]
    end
  end

  private
    def accessible?(url)
      response = Net::HTTP.get_response(URI.parse(url))
      if response.code === "200"
        return true
      else
        return false
      end
    end
end
