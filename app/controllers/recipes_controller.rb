class RecipesController < ApplicationController
  def index
    @user = User.includes(:recipes).find_by(id: params[:user_id])
    @recipes = @user.recipes.includes(:recipe_foods)
  end

  def show
    @recipe = @recipes.find(params[:id])
  end
end
