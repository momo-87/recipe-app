Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"
  get '/public_recipes', to: 'recipes#public_recipes'
  get '/shopping_list', to: 'foods#shopping_list', as: 'shopping_list'

  resources :foods, only: [:index, :new, :create]

  resources :users, only: %i[index show] do
    resources :recipes, only: %i[index show update] do
      resources :recipe_foods, only: %i[index show]
    end
  end
  delete 'foods/:id', to: 'foods#delete', as: 'delete_food'
end
