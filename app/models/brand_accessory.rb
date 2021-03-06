# frozen_string_literal: true
class BrandAccessory < ApplicationRecord
  belongs_to :brand
  validates :name, :category, :brand_id, :file, :presence => true
  mount_uploader :file, FileUploader
  CATEGORIES = %w[ppt_template word_template guidelines logo capability palette facts header rollup sticker video]
  validates :category, inclusion: { in: CATEGORIES }
  scope :has_category, -> (category) { where(category: category)}
  validates :file,
    :file_size => {
      :maximum => 100.megabytes.to_i
    }
end
