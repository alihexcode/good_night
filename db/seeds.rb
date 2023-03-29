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
friends = User.where.not(id: user.id).limit(3)
friends.each do |friend|
  start_time = 1.week.ago.to_datetime
  end_time = 1.day.ago.to_datetime
  (start_time..end_time).each do |datetime|
    tomorrow = datetime + 1.day
    friend.sleep_records.create!(start_time: datetime.change(hour: rand(19..23)), end_time: tomorrow.change(hour: rand(5..10)))
  end
  user.friendships.create!(friend: friend)
end
