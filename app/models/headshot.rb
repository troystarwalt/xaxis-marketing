class Headshot < ApplicationRecord
  belongs_to :brand
  mount_uploader :image, HeadshotsUploader
  validates_presence_of :first_name, :last_name, :title, :image, :brand_id
end
