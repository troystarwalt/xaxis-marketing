class Brand < ApplicationRecord
  has_many :logos, :dependent => :destroy
end
