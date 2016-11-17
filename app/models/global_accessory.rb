# frozen_string_literal: true
class GlobalAccessory < ApplicationRecord
    validates :name, :category, :file, :presence => true
    mount_uploader :file, FileUploader
    CATEGORIES = %w[image_bank generic]
    validates :category, inclusion: { in: CATEGORIES }
end
