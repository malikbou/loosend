# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require_relative 'addresses/addresses.rb'
include LondonAddresses

puts "Cleaning database..."

Review.destroy_all
puts "Destroyed reviews"

ToiletFeature.destroy_all
puts "Destroyed toilet features"

Toilet.destroy_all
puts "Destroyed toilets"

User.destroy_all
puts "Destroyed users"

puts "Creating users..."
user1 = { email: "admin@toil.et", password: "loo.send" }
user2 = { email: "daniela@tmail.com", password: "cleanLatrine1" }
user3 = { email: "gabriel@wc.com", password: "joeBidet" }
user4 = { email: "chirantan@sandas.com", password: "loosRus" }
user5 = { email: "malik@tolet.com", password: "love2poop" }

[user1, user2, user3, user4, user5].each do |attributes|
  user = User.create!(attributes)
  puts "Created #{user.email}"
end
puts "Finished users!"

puts "Creating toilets..."

# Attributes :name, :address, :opens_at, :closes_at, :fee, :toilet_code, :rating

toilet1 = { name: "The Queens Pisser", address: "44 Essex Rd, London N1 8LN",
            opens_at: "08:00", closes_at: "22:00",
            fee: rand(0.00..3.00), toilet_code: "ABC123", rating: rand(0..5)
          }
# Do the toilets need an image?
toilet2 = { name: "The Al Bion", address: "New City College, Hackney, Falkirk St, London N1 6HQ",
            opens_at: "07:00", closes_at: "19:00",
            fee: rand(0.00..3.00), toilet_code: "xyzabc", rating: rand(0..5)
          }
toilet3 = { name: "Session FArts Hub", address: "Columbia Road Flower Market,Columbia Rd, London E2 7RG",
            opens_at: "08:00", closes_at: "22:00",
            fee: rand(0.00..3.00), toilet_code: "69noice", rating: rand(0..5)
          }
toilet4 = { name: "Hackney Town Hall", address: "Hoxton, Geffrye St, London E2 8FF",
            opens_at: "08:00", closes_at: "22:00",
            fee: rand(0.00..3.00), toilet_code: "BHOSDK", rating: rand(0..5)
          }

toilet5 = { name: "Hoxton Station", address: "Hoxton, Geffrye St, London E2 8FF",
            opens_at: "08:00", closes_at: "22:00",
            fee: rand(0.00..3.00), toilet_code: "", rating: rand(0..5)
          }

toilet6 = { name: "Haggerston Station", address: "Haggerston, London E8 4DY",
            opens_at: "08:00", closes_at: "22:00",
            fee: rand(0.00..3.00), toilet_code: "", rating: rand(0..5)
          }

# toilet7 = { name: "Aures London", address: "18 Leake St, London SE1 7NN",
#             opens_at: "08:00", closes_at: "22:00",
#             fee: rand(0.00..3.00), toilet_code: "", rating: rand(0..5)
#           }

[toilet1, toilet2, toilet3, toilet4, toilet5, toilet6].each do |attributes|
  toilet = Toilet.create!(attributes)
  puts "Created #{toilet.name}"
end

photo_id = 0
addresses = LONDON.dup

30.times do
  attributes = {name: Faker::Restaurant.name, address: addresses.sample,
                opens_at: "08:00", closes_at: "22:00",
                fee: rand(0.00..3.00), toilet_code: Faker::String.random(length: 0..10), rating: rand(0..5)
                }
  toilet = Toilet.create!(attributes)
  puts "Created #{toilet.name} with photo id #{photo_id}"
  photo_id += 1
  addresses.delete(toilet.address)
end

puts "Finished toilets!"

# REMEMBER TO MAKE VENUES DYNAMIC WITH RANDOM DATA
# 10.times do
#   attributes = { user_id: User.first.id, toilet_id: Toilet.first.id, start_date: Date.yesterday, end_date: Date.tomorrow }
#   booking = Booking.create!(attributes)
#   puts "Created booking for #{booking.user.email} at #{booking.toilet.name}"
# end

# puts "Finished bookings!"
