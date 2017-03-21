class Photo < ApplicationRecord
  validates :title, :image, presence: true
  mount_uploader :image, ImageUploader
  acts_as_taggable_on :tags
end
