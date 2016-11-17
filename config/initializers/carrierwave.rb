# frozen_string_literal: true
CarrierWave.configure do |config|

  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.fog_provider = 'fog/aws'
      config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

        config.fog_credentials = {
          :provider               => 'AWS',                             # required
          :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],            # required
          :aws_secret_access_key  => ENV['AWS_SECRET_KEY'],     # required
          :region                 => 'us-east-1'                        # optional, defaults to 'us-east-1'
        }
        config.fog_directory  = 'xaxis-internal-stage'               # required
        #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
        #config.fog_public     = false                                  # optional, defaults to true
        config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
    end
  end



end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end
