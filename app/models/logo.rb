class Logo < ApplicationRecord
  belongs_to :brand
  mount_uploader :file, FileUploader
end
