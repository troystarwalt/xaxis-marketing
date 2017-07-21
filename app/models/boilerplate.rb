class Boilerplate < ApplicationRecord
  belongs_to :brand
  validates_presence_of :brand_id, presence: true
end
