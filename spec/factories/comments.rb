FactoryBot.define do
  factory :comment do
    content Faker::Hobbit.quote
    user
    prototype
  end
end
