# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
  User.create(name: Faker::Name.name)
end

# Generate example user with friends
user = User.first
friends = User.where.not(id: user.id).limit(5)
friends.each do |friend|
  friendship = user.friendships.build(friend: friend)
  friendship.save
end
