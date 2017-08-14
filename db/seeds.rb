5.times do |i|
  User.create(
    name:       Faker::StarWars.character,
    email:      "test_#{i}@test.com",
    password:   '11111111',
    avatar:     nil,
    profile:    Faker::StarWars.quote,
    occupation: Faker::StarWars.specie,
    position:   Faker::StarWars.planet
  )
end

100.times do
  Prototype.create(
    title:      Faker::HarryPotter.book,
    catch_copy: Faker::HarryPotter.quote,
    concept:    Faker::HarryPotter.house,
    user_id:    rand(1..5)
  )
end

200.times do
  Comment.create(
    content:      Faker::Hobbit.quote,
    user_id:      rand(1..5),
    prototype_id: rand(1..100)
  )
end

50.times do
  Like.create(
    user_id:      rand(1..5),
    prototype_id: rand(1..100)
  )
end
