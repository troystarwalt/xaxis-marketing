class FileUploader < BaseUploader

  def default_url(*args)
    random = ["xaxis", "lr", "turbine", "plista", "triad"]
    "https://robohash.org/#{random.sample}.png?size=200x200"
  end

  version :thumb, :if => :image? do
    process resize_to_limit: [100, 100]
  end

  version :preview, :if => :image? do
    process resize_to_fit: [400, 400]
  end

  def extension_whitelist
    %w(zip pdf ppt pptx doc docx ase png eps jpeg jpg dotx)
  end

end
