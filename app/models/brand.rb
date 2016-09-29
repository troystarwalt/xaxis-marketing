class Brand < ApplicationRecord
  has_many :logos, :dependent => :destroy
  accepts_nested_attributes_for :logos, :allow_destroy => true
  extend FriendlyId

  friendly_id :name, use: [:slugged, :finders]
end
