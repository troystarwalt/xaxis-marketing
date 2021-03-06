# frozen_string_literal: true
class GlobalAccessory < ApplicationRecord
    validates :name, :category, :presence => true
    mount_uploader :file, FileUploader
    CATEGORIES = %w[image_bank pr_kit generic]
    validates :category, inclusion: { in: CATEGORIES }
    validates :file,
      :file_size => {
        :maximum => 1000.megabytes.to_i
      }
end
