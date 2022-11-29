# require 'faker'
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
user1 = { email: "admin@admin.com", password: "adminadmin" }
user2 = { email: "daniela@cupcakes.com", password: "danielalovescupcakes" }
user3 = { email: "gabriel@cookies.com", password: "gabriellovescookies" }
user4 = { email: "chirantan@phones.com", password: "chirantanlovesphones" }
user5 = { email: "malik@chocolate.com", password: "malikloveschocolate" }

[user1, user2, user3, user4, user5].each do |attributes|
  user = User.create!(attributes)
  puts "Created #{user.email}"
end
puts "Finished users!"

puts "Creating toilets..."
toilet1 = { name: "Chirantan's loo", address: "Brewhouse Shoreditch", opens_at: '10:00:00', closes_at: '18:00:00', fee: 0, toilet_code: 'ABC', rating: 5}

[toilet1].each do |attributes|
  toilet = Toilet.create!(attributes)
  puts "Created #{toilet.name}"
end
puts "Finished toilets!"
