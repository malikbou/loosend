require 'faker'
require_relative 'addresses'
include LondonAddresses

puts "Cleaning database..."

ToiletFeature.destroy_all
puts "Destroyed reviews"

Feature.destroy_all
puts "Destroyed reviews"

Review.destroy_all
puts "Destroyed reviews"

Toilet.destroy_all
puts "Destroyed toilets"

User.destroy_all
puts "Destroyed users"

puts "Creating users..."
user1 = { email: "admin@admin.com", password: "adminadmin", first_name: "admin", last_name: "admin" }
user2 = { email: "daniela@cupcakes.com", password: "danielalovescupcakes", first_name: "Daniela", last_name: "Socaciu" }
user3 = { email: "gabriel@cookies.com", password: "gabriellovescookies", first_name: "Gabriel", last_name: "Bijlmakers" }
user4 = { email: "chirantan@phones.com", password: "chirantanlovesphones", first_name: "Chirantan", last_name: "Sahasrabudhe" }
user5 = { email: "malik@chocolate.com", password: "malikloveschocolate", first_name: "Malik", last_name: "Bouaoudia" }
[user1, user2, user3, user4, user5].each do |attributes|
  user = User.create!(attributes)
  puts "Created #{user.email}"
end
puts "Finished users!"

puts "Creating toilets..."
addresses = LONDON.dup
100.times do
  attributes = { name: Faker::Book.title, address: addresses.sample, opens_at: '10:00:00', closes_at: '19:00:00', fee: rand(0.00..10.00).round(2), toilet_code: rand(1000..9999), rating: rand(1..5)}
  toilet = Toilet.create!(attributes)
  puts "Created #{toilet.name} located at #{toilet.address}"
  addresses.delete(toilet.address)
end
puts "Finished toilets!"

# for reviews
# Faker::Movies::Lebowski.quote
# Faker::Quote.famous_last_words

puts "Creating reviews..."
puts "Finished reviews!"

puts "Creating features..."
puts "Finished features"

puts "Creating toilet features..."
puts "Finished toilet features!"
