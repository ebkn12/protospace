FactoryBot.define do
  factory :user do
    sequence(:name)       { |n| "testuser#{n}" }
    sequence(:email)      { |n| "test_#{n}@test.com" }
    password              'password'
    password_confirmation 'password'
    avatar do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'avatar.jpg'), 'image/jpeg')
    end
    profile               'テストプロフィール'
    occupation            'テスト職業'
    position              'テスト役職'
  end
end
