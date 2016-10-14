class BrandAccessory < ApplicationRecord
  belongs_to :brand
  validates :name, :category, :brand_id, :file, :presence => true
  mount_uploader :file, FileUploader
  CATEGORIES = %w[ppt_template word_template font guidelines logo capability palette facts]
  validates :category, inclusion: { in: CATEGORIES }
end
