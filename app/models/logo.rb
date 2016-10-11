class Logo < ApplicationRecord
  belongs_to :brand
  # Every logo must have a name (ie file name), be connected to a brand, and have an attachment
  validates :name, :brand_id, :file, :presence => true

  mount_uploader :file, FileUploader



end
