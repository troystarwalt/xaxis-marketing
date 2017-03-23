class Photo < ApplicationRecord
  validates :title, :tag_list, presence: true
  mount_uploader :image, ImageUploader
  acts_as_taggable_on :tags

  validate :image_xor_remote_url

  private
  def image_xor_remote_url
    puts "Check image:  #{image} "
    puts "Check url: #{remote_image_url}"
    if image.blank? && remote_image_url.blank?
      errors.add(:base, "Specify an image or remote url.")
    end
  end
end
