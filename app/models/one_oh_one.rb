class OneOhOne < ApplicationRecord
  mount_uploader :ppt_file, PptUploader
  mount_uploader :pdf_file, PdfUploader
  mount_uploader :image_preview, ImageUploader
  self.per_page = 9
  validates_presence_of :name, :ppt_file, :pdf_file

end
