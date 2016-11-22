# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  Profile.where(name: Faker::Name.name,
  geolocation: Faker::Address.latitude + ' ,' + Faker::Address.longitude,
  photo: Faker::Avatar.image(slug = nil, size = '300x300', format = 'png')).create
end
