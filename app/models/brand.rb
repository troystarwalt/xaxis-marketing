class Brand < ApplicationRecord
  has_many :brand_accessories, :dependent => :destroy
  has_many :headshots, :dependent => :destroy
  accepts_nested_attributes_for :brand_accessories, :allow_destroy => true
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def self.last_of_a_category(brand, category)
    this_brand = Brand.find_by_name(brand)
    this_brand.brand_accessories.where(category: category).last
  end
end
