class ContentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  case Rails.env
  when 'development', 'production'
    storage :fog
  when 'test'
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end
end
