class OneSheeter < ApplicationRecord
  belongs_to :platform
  mount_uploader :file, FileUploader

end
