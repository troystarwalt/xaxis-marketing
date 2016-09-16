class Logo < ApplicationRecord
  has_one :brand, :through => :materials
end
