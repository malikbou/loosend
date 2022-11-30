require 'faker'
require_relative 'addresses'
require_relative 'features'

include LondonAddresses, FeatureList

puts "Cleaning database..."

ToiletFeature.destroy_all
puts "Destroyed toilet features"

Feature.destroy_all
puts "Destroyed features"

Review.destroy_all
puts "Destroyed reviews"

Toilet.destroy_all
puts "Destroyed toilets"

User.destroy_all
puts "Destroyed users"

puts "Creating users..."

user1 = { email: "admin@toil.et", password: "loo.send", first_name: "admin", last_name: "admin" }
user2 = { email: "daniela@tmail.com", password: "cleanLatrine1", first_name: "Daniela", last_name: "Socaciu" }
user3 = { email: "gabriel@wc.com", password: "joeBidet", first_name: "Gabriel", last_name: "Bijlmakers" }
user4 = { email: "chirantan@sandas.com", password: "loosRus", first_name: "Chirantan", last_name: "Sahasrabudhe" }
user5 = { email: "malik@tolet.com", password: "love2poop", first_name: "Malik", last_name: "Bouaoudia" }
[user1, user2, user3, user4, user5].each do |attributes|
  user = User.create!(attributes)
  puts "Created #{user.first_name} with email: #{user.email}"
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

puts "Creating reviews from random users for random toilets..."
random_users = User.limit(5).order("RANDOM()")
random_toilets = Toilet.limit(100).order("RANDOM()")

200.times do
  random_comment = [Faker::Movies::Lebowski.quote, Faker::Quote.famous_last_words]
  attributes = { user_id:random_users.sample.id, toilet_id: random_toilets.sample.id, toilet_rating: rand(1..5), hygiene_rating: rand(1..5), comment: random_comment.sample }
  review = Review.create!(attributes)
  puts "#{review.user.first_name} wrote a review for #{review.toilet.name}: #{review.comment}"
end
puts "Finished reviews!"

puts "Creating features..."
FEATURE_LIST.each do |f|
  feature = Feature.create!(name: f)
  puts "Added #{feature.name} to features"
end
puts "Finished features!"

puts "Creating toilet features..."
# for 100 toilets
Toilet.all.each do |toilet|
  4.times do
    attributes = { toilet_id: toilet.id, feature_id: Feature.find(rand(1..Feature.count)).id }
    toilet_feature = ToiletFeature.create!(attributes)
    join_query = "
      INNER JOIN toilet_features
        ON features.id = toilet_features.feature_id
      INNER JOIN toilets
        ON toilets.id = toilet_features.toilet_id"
    puts "Created: #{Feature.joins(join_query).name}"
  end
end
puts "Finished toilet features!"
