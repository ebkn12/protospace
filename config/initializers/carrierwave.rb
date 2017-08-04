require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1'
  }

  case Rails.env
  when 'development'
    config.fog_directory = 'ebkn12-protospace-image'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/ebkn12-protospace-image'
  when 'production'
    config.fog_directory = 'ebkn12-protospace-image'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/ebkn12-protospace-image'
  end
end
