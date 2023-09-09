require_relative '../rails_helper'

RSpec.describe 'Recipe', type: :system do
  # Create some test users and their associated data
  before do
    @user1 = User.create!(name: 'Christian Momo', email: 'mm@recipapp.com', password: '123456')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    @recipe1 = @user1.recipes.create!(name: 'recipe 1', description: 'recipe 1 description', cooking_time: 10,
                                      preparation_time: 5)

    food = @user1.foods.create!(name: 'food 1', measurement_unit: 'kg', price: 10, quantity: 5)
    RecipeFood.create!(quantity: 5, food:, recipe: @recipe1)
  end

  it 'should render the food index page' do
    visit foods_path

    expect(page).to have_content('Food')
  end

  it 'should redirect to add new food page' do
    visit recipes_path
    find('#add-food-link').click

    sleep(5)
    current_path
    expect(current_path).to eq(new_food_path)
  end
end
