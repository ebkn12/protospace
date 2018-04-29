FactoryBot.define do
  factory :comment do
    content 'テストコメント'
    user
    prototype
  end
end
