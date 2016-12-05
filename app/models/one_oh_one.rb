class OneOhOne < ApplicationRecord
  mount_uploader :ppt_file, PptUploader
  mount_uploader :pdf_file, PdfUploader
  mount_uploader :image_preview, ImageUploader

  validates_presence_of :name, :ppt_file, :pdf_file

  # validate :file_format, :image_preview

  # def file_format
  #   unless valid_extension? self.image_preview.filename
  #     errors[:document] << "Invalid file format"
  #   end
  # end
  #
  # def valid_extension?(filename)
  #   ext = File.extname(filename)
  #   byebug
  #   %w(.jpg .jpeg .png).include? ext.downcase
  # end

end
