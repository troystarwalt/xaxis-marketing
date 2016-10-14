class GlobalAccessory < ApplicationRecord

    validates :name, :category, :file, :presence => true
    mount_uploader :file, FileUploader

end
