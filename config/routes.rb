Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/public_recipes', to: 'recipes#public_recipes'
  delete '/recipes/:id/:food_id', to: 'recipes#remove_food_from_recipe', as: 'recipe_food'

  resources :users, only: %i[index show]
  resources :recipes, only: %i[index show update destroy] do
    resources :recipe_foods, only: [:index, :show, :new, :create]
  end
end
