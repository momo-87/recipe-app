# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
require 'faker'

User.destroy_all
Recipe.destroy_all
RecipeFood.destroy_all
Food.destroy_all

quantity_users = 10
quantity_recipes = 10
quantity_foods = 10
quantity_recipe_foods = 20
users = []

for user_position in 1..quantity_users do
  temp_user = User.create!(name: "User Number #{user_position}")
  temp_user.skip_confirmation!
  users << temp_user
end

for user_position in 0..(quantity_users - 1) do
  for recipe_position in 0..Random.rand(quantity_recipes - 1) do
    temp_recipe = Recipe.create!(user: users[user_position], name: "Recipe #{recipe_position + 1}", cooking_time = Faker::Number.within(range: 10..120).to_s + ' ' + Faker::Measurement.metric('minute'), description: Faker::Lorem.sentences(number: 2 + Random.rand(10)).join(' '))
    for comment_position in 0..Random.rand(quantity_comments) do
      position = Random.rand(quantity_users)
      Comment.create!(post: temp_post, author: users[Random.rand(quantity_users)], text: Faker::Lorem.sentences(number: 12 + Random.rand(20)).join(' '))
    end
    for like in 1..Random.rand(quantity_likes) do
      Like.create!(post: temp_post, author: users[Random.rand(quantity_users)])
    end
  end
end

puts "Created #{User.count} users"
puts "Created #{Post.count} posts"
puts "Created #{Comment.count} comments"
puts "Assigned #{Like.count} likes, randomly"