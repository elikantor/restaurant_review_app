10.times do 
    User.create(name: Faker::Name.first_name, favorite_food_genre: Faker::Restaurant.type, home_location: Faker::Address.community, work_study_location: Faker::Address.community)
    Restaurant.create(name: Faker::Restaurant.name, food_genre: Faker::Restaurant.type, location: Faker::Address.community)
    Review.create(user_id: User.all.sample.id, restaurant_id: Restaurant.all.sample.id, content: Faker::Hacker.say_something_smart)
end