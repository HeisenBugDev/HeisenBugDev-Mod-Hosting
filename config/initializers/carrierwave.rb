if defined?(CarrierWave)
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end

  CarrierWave.configure do |config|
    if Rails.env.development? || Rails.env.test?
      config.storage = :file
    else
      config.storage = :fog
      config.fog_credentials = {
        provider: 'AWS',                        # required
        aws_access_key_id: ENV['HBD_AWS_KEY'],                        # required
        aws_secret_access_key: ENV['HBD_AWS_SECRET']                        # required
        # :region => 'us-east-1'
      }
      config.fog_directory  = 'heisenbugdev'                     # required
      config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }  # optional, defaults to {}
      config.fog_use_ssl_for_aws = false
    end
  end
end
