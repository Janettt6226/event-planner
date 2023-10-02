# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Event.destroy_all
User.destroy_all

10.times do
  new_event = Event.create(
    title: Faker::Hobby.activity,
    start_time: Faker::Date.between(from: '2023-10-03', to: '2024-01-03'),
    location: Faker::Address.city,
    description: Faker::Lorem.sentence
  )
  puts new_event.title
end

paul = User.create!(
  username: 'Paul',
  password: "password",
  email: "paul@gmail.com"
)
puts paul.username

doud = User.create!(
  username: 'Doud',
  password: "password",
  email: "doud@gmail.com"
)
puts doud.username

raph = User.create!(
  username: 'Raph',
  password: "password",
  email: "raph@gmail.com"
)
puts raph.username

paulaire = User.create!(
  username: 'Paulaire',
  password: "password",
  email: "paulaire@gmail.com"
)
puts paulaire.username

adri = User.create!(
  username: 'Adri',
  password: "password",
  email: "adri@gmail.com"
)
puts adri.username

bev = User.create!(
  username: 'Bev',
  password: "password",
  email: "bev@gmail.com"
)
puts bev.username

lolo = User.create!(
  username: 'Lolo',
  password: "password",
  email: "lolo@gmail.com"
)
puts lolo.username

nono = User.create!(
  username: 'Nono',
  password: "password",
  email: "nono@gmail.com"
)
puts nono.username
