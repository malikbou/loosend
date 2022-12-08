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
  email: "filipe@loosend.com",
  password: "ilovetopoop",
  first_name: "Filipe",
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
# 4 star rating overall
# review:
toilet6 = {
  name: "Moko Made Cafe",
  address: "211 Kingsland Rd London E2 8AN",
  opens_at: '08:30:00',
  closes_at: '18:00:00',
  fee: rand(0.00..10.00).round(2),
  toilet_code: rand(1000..9999),
  rating: rand(3..5)
}
# high overall rating
# features; enclosed stall, mirror, hand dryer, sanitary bin
# only positive reviews
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
end
puts "Finished REAL toilets with toilet features!"
puts "\n"

puts "Adding features for Moko Moko & Long White Cloud Cafe..."
Toilet.find([1,6,7]).each do |toilet|
  Feature.find([5,6,8]).each do |feature|
    ToiletFeature.create(toilet_id: toilet.id, feature_id: feature.id)
    puts "\tAdded #{feature.name} feature to #{toilet.name}"
  end
  # Add Mirror to Long white but not MokoMoko
  ToiletFeature.create(toilet_id: toilet.id, feature_id: 7) if toilet.id == 7
end
puts "Finished adding features for Moko Moko & Long White Cloud Cafe..."
puts "\n"

puts "Adding features to other REAL toilets!"
Toilet.where.not(id: [1,6,7]).each do |toilet|
  Feature.all.sample(rand(3..5)).each do |feature|
    ToiletFeature.create(toilet_id: toilet.id, feature_id: feature.id)
    puts "\tAdded #{feature.name} feature to #{toilet.name}"
  end
end
puts "Finished adding features to other REAL toilets!"
puts "\n"

puts "Adding ratings from REAL users to REAL toilets..."
random_users = User.offset(1)
# add only fake ratings to toilet
Toilet.all.each do |toilet|
  rand(3..100).times do
    toilet.id == 1 ? toilet_rating = rand(0..3) : toilet_rating = rand(4..5) # bad reviews brewhouse
    puts "Toilet rating: #{toilet_rating}"
    attributes = {
      user_id: random_users.sample.id,
      toilet_id: toilet.id,
      toilet_rating: toilet_rating
    }
    review = Review.create!(attributes)
    puts "\t#{review.user.first_name} rated #{review.toilet.name} #{review.toilet_rating} ⭐️"
  end
end

# Seed FAKE revies to Long White Cloud Cafe
reviews = ["My baby boy threw up on me (again). So glad I was able to find a place with a hand dryer to clean up the mess.",
  "Excellent toilet! Felt like I was sitting on a throne.",
  "The hand soap here is heavenly. This is my go-to toilet when I’m in the area."
]
reviews.each do |review|
  # add fake rating & comments to toilet
  attributes = {
    user_id: random_users.sample.id,
    toilet_id: 7,
    toilet_rating: rand(4..5),
    comment: review
  }
  review = Review.create!(attributes)
  puts "\t#{review.user.first_name} wrote a review for #{review.toilet.name}: #{review.comment}"
end
puts "Finished reviews!"

puts "Creating FAKE toilets..."
addresses = LONDON.dup
LONDON.length.times do
  attributes = {
    name: Faker::Book.title,
    address: addresses.sample,
    opens_at: "#{rand(8..12)}:00:00",
    closes_at: "#{rand(13..21)}:00:00",
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

puts "Creating reviews from random users to FAKE toilets..."
random_toilets = Toilet.offset(8)

300.times do
  # add fake rating & comments to toilet
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

puts "Adding ratings from random users for random toilets..."
# add only fake ratings to toilet
Toilet.offset(8).each do |toilet|
  rand(3..100).times do
    attributes = {
      user_id: random_users.sample.id,
      toilet_id: toilet.id,
      toilet_rating: rand(3..5)
    }
    review = Review.create!(attributes)
    puts "\t#{review.user.first_name} rated #{review.toilet.name} #{review.toilet_rating} ⭐️"
  end
end
