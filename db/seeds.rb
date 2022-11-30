require 'faker'
require_relative 'addresses'
require_relative 'features'

include LondonAddresses, FeatureList

puts "Cleaning database..."

ToiletFeature.destroy_all
puts "Destroyed toilet features"

Review.destroy_all
puts "Destroyed reviews"

Toilet.destroy_all
puts "Destroyed toilets"

Feature.destroy_all
puts "Destroyed features"

User.destroy_all
puts "Destroyed users"
puts "\n"

puts "Creating users..."
user1 = {
  email: "admin@toil.et",
  password: "loo.send",
  first_name: "Ad",
  last_name: "Min"
}
user2 = {
  email: "daniela@tmail.com",
  password: "cleanLatrine1",
  first_name: "Daniela",
  last_name: "Socaciu"
}
user3 = {
  email: "gabriel@wc.com",
  password: "joeBidet",
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
  email: "malik@tolet.com",
  password: "love2poop",
  first_name: "Malik",
  last_name: "Bouaoudia"
}
[user1, user2, user3, user4, user5].each do |attributes|
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

puts "Creating toilets..."
addresses = LONDON.dup
100.times do
  attributes = {
    name: Faker::Book.title,
    address: addresses.sample,
    opens_at: '10:00:00',
    closes_at: '19:00:00',
    fee: rand(0.00..10.00).round(2),
    toilet_code: rand(1000..9999),
    rating: rand(1..5)
  }
  toilet = Toilet.create!(attributes)
  puts "Created #{toilet.name} located at #{toilet.address}"
  addresses.delete(toilet.address)

  Feature.all.sample(rand(3..5)).each do |feature|
    features = ToiletFeature.create(toilet_id: toilet.id, feature_id: feature.id + 1)
    puts "\tAdded #{feature.name} feature to #{toilet.name}"
  end
end
puts "Finished toilets & toilet features!"
puts "\n"

puts "Creating reviews from random users for random toilets..."
random_users = User.limit(5).order("RANDOM()")
random_toilets = Toilet.limit(100).order("RANDOM()")
200.times do
  random_comment = [Faker::Movies::Lebowski.quote, Faker::Quote.famous_last_words]
  attributes = {
    user_id: random_users.sample.id,
    toilet_id: random_toilets.sample.id,
    toilet_rating: rand(1..5),
    hygiene_rating: rand(1..5),
    comment: random_comment.sample
  }
  review = Review.create!(attributes)
  puts "\t#{review.user.first_name} wrote a review for #{review.toilet.name}: #{review.comment}"
end
puts "Finished reviews!"
