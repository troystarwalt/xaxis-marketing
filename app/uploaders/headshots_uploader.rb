# frozen_string_literal: true
class HeadshotsUploader < BaseUploader

  version :thumb, :if => :image? do
    process resize_to_limit: [200, 200]
  end

  version :large, :if => :image? do
    process resize_to_fit: [1024, 768]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

end
