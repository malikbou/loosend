require 'faker'
require_relative 'addresses'
require_relative 'features'

include LondonAddresses, FeatureList

puts "Cleaning database..."

ToiletFeature.destroy_all
puts "Destroyed toilet features"

Review.destroy_all
puts "Destroyed reviews"

Feature.destroy_all
puts "Destroyed features"

Toilet.destroy_all
puts "Destroyed toilets"

User.destroy_all
puts "Destroyed users"
puts "\n"

puts "Creating users..."
user1 = {
  email: "admin@admin",
  password: "adminadmin",
  first_name: "Admin",
  last_name: "Adminton"
}
user2 = {
  email: "daniela@loosend.com",
  password: "ilovetopoop",
  first_name: "Daniela",
  last_name: "Socaciu"
}
user3 = {
  email: "gabriel@loosend.com",
  password: "ilovetopoop",
  first_name: "Gabriel",
  last_name: "Bijlmakers"
}
user4 = {
  email: "chirantan@sandas.com",
  password: "loosRus",
  first_name: "Chirantan",
  last_name: "Sahasrabudhe"
}
user5 = {
  email: "malik@loosend.com",
  password: "ilovetopoop",
  first_name: "Malik",
  last_name: "Bouaoudia"
}
user6 = {
  email: "felipe@loosend.com",
  password: "ilovetopoop",
  first_name: "Felipe",
  last_name: "Nossa"
}
[user1, user2, user3, user4, user5, user6].each do |attributes|
  user = User.create!(attributes)
  puts "\tCreated #{user.first_name} with email: #{user.email}"
end
puts "Finished users!"
puts "\n"

puts "Creating features..."
FEATURE_LIST.each do |f|
  feature = Feature.create!(name: f)
  puts "\tAdded #{feature.name} to features"
end
puts "Finished features!"
puts "\n"

puts "Creating REAL toilets..."
toilet1 = {
  name: "Brewhouse & Kitchen",
  address: "397-400 Geffrye St London E2 8HZ",
  opens_at: '12:00:00',
  closes_at: '23:00:00',
  fee: rand(0.00..10.00).round(2),
  toilet_code: rand(1000..9999),
  rating: 3
}
toilet2 = {
  name: "Howl At The Moon",
  address: "178 Hoxton St London N1 5LH",
  opens_at: '12:00:00',
  closes_at: '01:00:00',
  fee: rand(0.00..10.00).round(2),
  toilet_code: rand(1000..9999),
  rating: 5
}
toilet3 = {
  name: "The Lion & Lamb",
  address: "46 Fanshaw St London N1 6LG",
  opens_at: '16:00:00',
  closes_at: '02:00:00',
  fee: rand(0.00..10.00).round(2),
  toilet_code: rand(1000..9999),
  rating: 4
}
toilet4 = {
  name: "The George & Vulture",
  address: "63 Pitfield St London N1 6BU",
  opens_at: '12:00:00',
  closes_at: '23:00:00',
  fee: rand(0.00..10.00).round(2),
  toilet_code: rand(1000..9999),
  rating: rand(3..5)
}
toilet5 = {
  name: "The Stag's Head",
  address: "55 Orsman Rd London N1 5RA",
  opens_at: '10:00:00',
  closes_at: '19:00:00',
  fee: rand(0.00..10.00).round(2),
  toilet_code: rand(1000..9999),
  rating: 3
}
toilet6 = {
  name: "Moko Made Cafe",
  address: "211 Kingsland Rd London E2 8AN",
  opens_at: '08:30:00',
  closes_at: '18:00:00',
  fee: rand(0.00..10.00).round(2),
  toilet_code: rand(1000..9999),
  rating: rand(3..5)
}
toilet7 = {
  name: "Long White Cloud Cafe",
  address: "151 Hackney Rd, London E2 8JL",
  opens_at: '07:30:00',
  closes_at: '19:00:00',
  fee: rand(0.00..10.00).round(2),
  toilet_code: rand(1000..9999),
  rating: rand(3..5)
}
toilet8 = {
  name: "Museum of the Home",
  address: "136 Kingsland Rd, London E2 8EA",
  opens_at: '10:00:00',
  closes_at: '18:00:00',
  fee: rand(0.00..10.00).round(2),
  toilet_code: rand(1000..9999),
  rating: rand(3..5)
}
[toilet1, toilet2, toilet3, toilet4, toilet5, toilet6, toilet7, toilet8].each do |attributes|
  toilet = Toilet.create!(attributes)
  puts "Created #{toilet.name} located at #{toilet.address}"

  # add random features to real toilets
  Feature.all.sample(rand(3..5)).each do |feature|
    ToiletFeature.create(toilet_id: toilet.id, feature_id: feature.id)
    puts "\tAdded #{feature.name} feature to #{toilet.name}"
  end
end
puts "Finished REAL toilets with toilet features!"
puts "\n"

puts "Creating FAKE toilets..."
addresses = LONDON.dup
100.times do
  attributes = {
    name: Faker::Book.title,
    address: addresses.sample,
    opens_at: '10:00:00',
    closes_at: '19:00:00',
    fee: rand(0.00..10.00).round(2),
    toilet_code: rand(1000..9999),
    rating: rand(3..5)
  }
  toilet = Toilet.create!(attributes)
  puts "Created #{toilet.name} located at #{toilet.address}"
  addresses.delete(toilet.address)

  Feature.all.sample(rand(3..5)).each do |feature|
    ToiletFeature.create(toilet_id: toilet.id, feature_id: feature.id)
    puts "\tAdded #{feature.name} feature to #{toilet.name}"
  end
end
puts "Finished FAKE toilets with toilet features!"
puts "\n"

puts "Creating reviews from random users for random toilets..."
random_users = User.limit(6).order("RANDOM()")
random_toilets = Toilet.limit(100).order("RANDOM()")
300.times do
  random_comment = [Faker::Movies::Lebowski.quote, Faker::TvShows::MichaelScott.quote, Faker::Quote.famous_last_words]
  attributes = {
    user_id: random_users.sample.id,
    toilet_id: random_toilets.sample.id,
    toilet_rating: rand(3..5),
    comment: random_comment.sample
  }
  review = Review.create!(attributes)
  puts "\t#{review.user.first_name} wrote a review for #{review.toilet.name}: #{review.comment}"
end
puts "Finished reviews!"
