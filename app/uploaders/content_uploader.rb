class ContentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  # if Rails.env == 'test'
  #   storage :file
  # else
  #   storage :fog
  # end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fit: [300, 200]

  def extension_white_list
    %w[jpg jpeg gif png]
  end
end
