class ExpertInterview < ApplicationRecord
  mount_uploader :image, ExpertInterviewImageUploader
  self.per_page = 8
end
