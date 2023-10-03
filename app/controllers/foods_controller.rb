class FoodsController < ApplicationController
  def index
    @foods = Food.where({ user_id: current_user.id })
  end

  def new
    @food = Food.new
  end

  def shopping_list
    foods = Food.includes(:recipe_foods).where({ user_id: current_user.id })
    @shopping_list = []
    @total_price = 0
    foods.each do |food|
      shopping_list_item = {
        food: food.name,
        quantity: calculate_missing_food(food),
        unit: food.measurement_unit,
        unit_price: food.price
      }
      @total_price += shopping_list_item[:quantity] * shopping_list_item[:unit_price]
      @shopping_list << shopping_list_item if (shopping_list_item[:quantity]).positive?
    end
  end

  def create
    name = food_params[:name]
    measurement_unit = food_params[:measurement_unit]
    quantity = food_params[:quantity]
    price = food_params[:price]
    food = Food.new(user_id: current_user.id, name:, measurement_unit:, price:, quantity:)

    if food.save
      redirect_to foods_path, notice: 'Food created successfully!'
    else
      render :new, notice: 'An error occured while creating a new food'
    end
  end

  def delete
    @food = Food.find(params[:id])
    if @food.destroy
      redirect_to foods_path, notice: 'Food deleted successfully!'
    else
      redirect_to foods_path, alert: 'Unable to delete the food item.'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def calculate_missing_food(food)
    missing_food = -food.quantity
    food.recipe_foods.each do |recipe_food|
      missing_food += recipe_food.quantity
    end

    return 0 if missing_food <= 0

    missing_food
  end
end
