class Platform < ApplicationRecord
  has_many :logos, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :infographics, dependent: :destroy
  has_many :one_sheeters, dependent: :destroy
  has_many :case_studies, dependent: :destroy
  accepts_nested_attributes_for :logos, :videos, :infographics, :one_sheeters, :allow_destroy => true
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]


end
