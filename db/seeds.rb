# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.destroy_all

50.times do
  tags = Post.valid_tags
  Post.create!(
    title: Faker::Book.title,
    text: Faker::Lorem.paragraph(2),
    author: Faker::GameOfThrones.character
  ).tap do |post|
    post.tag_list.add Post.valid_tags.sample
    post.save
  end
end

puts "posts created"
AdminUser.destroy_all
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
