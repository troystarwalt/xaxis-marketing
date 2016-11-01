class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  after :store, :get_text_from_file
  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    random = ["xaxis", "lr", "turbine", "plista", "triad"]
    "https://robohash.org/#{random.sample}.png?size=200x200"
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
    version :thumb, :if => :image? do
      process resize_to_limit: [100, 100]
    end

    version :preview, :if => :image? do
      process resize_to_fit: [400, 400]
    end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    if model == 'CaseStudy'
      %w(pdf)
    elsif model == 'Logo'
      %w(png eps)
    else
      %w(zip pdf ppt pptx doc docx ase png eps jpeg jpg dotx)
    end
  end


  # We are randomizing the name of the file here to protect against duplication.
  def filename
    if model.class.name == "CaseStudy"
     "#{model.title.parameterize}-#{secure_token(10)}.#{file.extension}" if original_filename.present?
    else
      "#{model.name.parameterize}-#{secure_token(10)}.#{file.extension}" if original_filename.present?
    end
  end

  def get_text_from_file(file)
    return true unless model.class.name == 'CaseStudy'
    reader = PDF::Reader.new(self.file.file)
    text = ""
    for page in reader.pages do
      text << page.text
    end
    self.model.update(searchable_pdf_text: text)
  end

  protected

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

end
