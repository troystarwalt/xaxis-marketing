class CaseStudy < ApplicationRecord
  belongs_to :platform
  mount_uploader :pdf_attachment, FileUploader
  self.per_page = 6
  acts_as_taggable_on :industries

  def get_pretty_release_date
    release_date.to_date.strftime("%m\/\%d\/\%Y")
  end
end
