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

  def update
    @user = User.includes(:recipes).find_by(id: params[:user_id])
    @recipe = @user.recipes.includes(:recipe_foods).find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to user_recipe_path(@user, @recipe)
    else
      redirect_to user_recipe_path(@user, @recipe)
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:public)
  end
end
