FactoryGirl.define do
  factory :prototype do
    title       Faker::HarryPotter.book
    catch_copy  Faker::HarryPotter.quote
    concept     Faker::HarryPotter.house
    user
  end
end
