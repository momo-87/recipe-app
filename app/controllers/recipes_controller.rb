class RecipesController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(:recipes).find_by(id: params[:user_id])
    @recipes = @user.recipes.includes(:recipe_foods)
  end

  def show
    @user = User.includes(:recipes).find_by(id: params[:user_id])
    @recipe = @user.recipes.includes(:recipe_foods).find(params[:id])
    @recipe_foods = @recipe.recipe_foods
    @foods = Food.where(user_id: @user.id)
    @current_user = current_user
  end

  def update
    @user = User.includes(:recipes).find_by(id: params[:user_id])
    @recipe = @user.recipes.includes(:recipe_foods).find(params[:id])

    redirect_to user_recipe_path(@user, @recipe)
  end

  def public_recipes
    @users = User.includes(:recipes).all
    @foods = Food.includes(:recipe_foods).all
    @public_recipes = Recipe.includes(:user, :recipe_foods).where(public: true)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:public)
  end
end
