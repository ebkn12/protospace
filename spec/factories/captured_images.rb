FactoryBot.define do
  factory :captured_image do
    content {
      fixture_file_upload("#{Rails.root}/spec/fixtures/images/prototype.jpg", 'image/jpeg')
    }
    status Faker::Number.between(0, 1)
    prototype
  end
end
