FactoryGirl.define do
  pass = Faker::Internet.password(8)

  factory :user do
    name                  Faker::StarWars.character
    email                 Faker::Internet.email
    password              pass
    password_confirmation pass
    avatar                {
      fixture_file_upload("#{Rails.root}/spec/fixtures/images/avatar.jpg", 'image/jpeg')
    }
    profile               Faker::StarWars.quote
    position              Faker::StarWars.planet
    occupation            Faker::StarWars.specie
  end
end
