FactoryGirl.define do
  factory :captured_image do
    content Rack::Test::UploadedFile.new(
      File.join(Rails.root, 'spec/fixtures/images/prototype.jpg')
    )
    user
    prototype
  end
end
