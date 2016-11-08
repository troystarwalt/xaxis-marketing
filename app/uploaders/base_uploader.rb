class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    model_name = if model.try(:title)
                   model.title
                 else
                   model.name
                 end
    "#{model_name.parameterize}-#{secure_token(10)}.#{file.extension}" if original_filename.present?
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
