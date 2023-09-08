Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/public_recipes', to: 'recipes#public_recipes'
  resources :users, only: %i[index show] do
    resources :recipes, only: %i[index show update destroy] do
      resources :recipe_foods, only: %i[index show]
    end
  end
end
