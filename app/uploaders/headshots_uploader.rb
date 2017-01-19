# frozen_string_literal: true
class HeadshotsUploader < BaseUploader

  version :thumb, :if => :image? do
    process resize_to_limit: [200, 250]
  end

  version :large, :if => :image? do
    process resize_to_fit: [720, 900]
  end

  version :small, :if => :image? do
    process resize_to_fit: [720, 900]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

end
