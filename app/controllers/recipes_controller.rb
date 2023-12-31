class RecipesController < ApplicationController
  # Load and authorize the appropriate resource for the controller
  load_and_authorize_resource

  def index
    # Used 'includes' method to minimize N+1 Queries:
    @recipes = Recipe.includes(:recipe_foods).where(user_id: current_user.id) if current_user
    @recipes = Recipe.includes(:recipe_foods).where(public: true) unless current_user
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def create
    name = recipe_params[:name]
    preparation_time = recipe_params[:preparation_time] || 0
    cooking_time = recipe_params[:cooking_time] || 0
    description = recipe_params[:description]
    recipe = Recipe.new(user_id: current_user.id, name:, preparation_time:, description:, cooking_time:)

    if recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      redirect_to recipe_path(@recipe), notice: 'Recipe could not be upddated'
    end
  end

  def destroy
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])

    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe successfully deleted'
    else
      redirect_to recipes_path, notice: 'Recipe could not be deleted'
    end
  end

  def public_recipes
    @users = User.includes(:recipes).all
    @foods = Food.includes(:recipe_foods).all
    @public_recipes = Recipe.includes(:user, :recipe_foods).where(public: true).order(created_at: :desc)
    @current_user = current_user
  end

  def remove_food_from_recipe
    @recipe_food = RecipeFood.includes(:food).find_by(recipe_id: params[:id], food_id: params[:food_id])
    @recipe_food.destroy
    redirect_to recipe_path(params[:id])
  end

  private
  # Used private method to enforce stringent security measures for browser request parameters
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
