# frozen_string_literal: true
class Infographic < ApplicationRecord
  belongs_to :platform
  mount_uploader :file, FileUploader
  mount_uploader :image_preview, FileUploader
end
