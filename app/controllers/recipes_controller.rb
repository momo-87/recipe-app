class RecipesController < ApplicationController
  def index
    @user = User.includes(:recipes).find_by(id: params[:user_id])
    @recipes = @user.recipes.includes(:recipe_foods)
  end

  def show
    @user = User.includes(:recipes).find_by(id: params[:user_id])
    @recipe = @user.recipes.includes(:recipe_foods).find(params[:id])
    @recipe_foods = @recipe.recipe_foods
    @foods = Food.where(user_id: @user.id)
  end
end
