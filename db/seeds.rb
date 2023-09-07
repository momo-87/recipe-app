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

quantity_users = 5
quantity_recipes = 5
quantity_foods = 5
quantity_recipe_foods = 5
users = []

for user_position in 1..quantity_users do
  temp_user = User.create!(name: "User Number #{user_position}", email: "user#{user_position}@recipapp.com", password: "recipapp#{user_position}")
  temp_user.skip_confirmation!
  users << temp_user
end

for user_position in 0..(quantity_users - 1) do
  for recipe_position in 0..Random.rand(quantity_recipes - 1) do
    temp_recipe = Recipe.create!(user: users[user_position], name: "Recipe #{recipe_position + 1}", preparation_time: "#{Faker::Number.within(range: 10..60)} minutes", cooking_time: "#{Faker::Number.within(range: 10..60)} minutes", description: Faker::Lorem.sentences(number: 2 + Random.rand(10)).join(' '))
    for recipe_foods_position in 0..Random.rand(quantity_recipe_foods - 1) do
      temp_food = Food.create!(user: users[user_position], name: "Food #{rand(1..quantity_foods)}", measurement_unit: "unit", price: Faker::Number.between(from: 1, to: 100), quantity: Faker::Number.between(from: 1, to: 20))
      RecipeFood.create!(recipe: temp_recipe, food: temp_food, quantity: Faker::Number.between(from: 1, to: 20))
    end
  end
end

puts "Created #{User.count} users"
puts "Created #{Recipe.count} recipes"
puts "Created #{Food.count} foods"
puts "Assigned #{RecipeFood.count} recipe_foods, randomly"