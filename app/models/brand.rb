# frozen_string_literal: true
class Brand < ApplicationRecord
  has_many :brand_accessories, :dependent => :destroy
  has_many :headshots, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_one :boilerplate, :dependent => :destroy
  accepts_nested_attributes_for :brand_accessories, :allow_destroy => true
  scope :included_in_nav, -> {where(main_nav: true)}
  scope :included_in_presentation_hub, -> {where(presentation_hub: true)}
  # accepts_nested_attributes_for :headshots, :allow_destroy => true
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
