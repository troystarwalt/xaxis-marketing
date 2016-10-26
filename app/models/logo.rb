class Logo < ApplicationRecord
  belongs_to :platform
  mount_uploader :file, FileUploader

  before_save :update_file_attributes

  def is_image?
    self.content_type.start_with? 'image'
  end

  private

  def update_file_attributes
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end


end
