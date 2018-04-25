FactoryBot.define do
  factory :captured_image do
    content do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'prototype.jpg'), 'image/jpeg')
    end
    status 0
    prototype
  end
end
