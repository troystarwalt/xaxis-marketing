class Logo < ApplicationRecord
  belongs_to :platform
  mount_uploader :file, FileUploader
end
