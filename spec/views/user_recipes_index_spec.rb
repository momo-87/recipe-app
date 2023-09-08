require_relative '../rails_helper'

RSpec.describe 'Recipe', type: :system do
  # Create some test users and their associated data
  before do
    @user1 = User.create!(name: 'Christian Momo', email: 'mm@recipapp.com', password: '123456')
    @user2 = User.create!(name: 'Mael Momo', email: 'ma@recipapp.com', password: '123457')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    @recipe1 = @user1.recipes.create!(name: 'recipe 1', description: 'recipe 1 description', cooking_time: 10, preparation_time: 5)
    @recipe2 = @user2.recipes.create!(name: 'recipe 2', description: 'recipe 2 description', cooking_time: 5, preparation_time: 2)

    food = @user1.foods.create!(name: 'food 1', measurement_unit: 'kg', price: 10, quantity: 5)
    recipe_food = RecipeFood.create!(quantity: 5, food: food, recipe: @recipe1)
  end

  it 'displays recipe information on the User recipe index page' do
    visit recipes_path

    expect(page).to have_content('recipe 1')
    expect(page).to have_content('recipe 1 description')
  end

  it 'redirects to recipe show page when clicking on Details' do
    visit recipes_path
    find("a[id='#{@recipe1.id}']").click

    sleep(5)
    current_path
    expect(current_path).to eq(recipe_path(@recipe1.id))
  end

end
