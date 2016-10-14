class Brand < ApplicationRecord
  has_many :brand_accessories, :dependent => :destroy
  has_many :headshots, :dependent => :destroy
  accepts_nested_attributes_for :brand_accessories, :allow_destroy => true
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
