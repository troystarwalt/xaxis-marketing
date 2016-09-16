class Brand < ApplicationRecord
  has_many :logos, :through => :materials
end
