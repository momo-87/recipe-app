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

    redirect_to user_recipe_path(@user, @recipe)
  end

  def public_recipes
    @users = User.all
    @foods = Food.all
    @public_recipes = Recipe.includes(:user, :recipe_foods).where(public: true)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:public)
  end
end
