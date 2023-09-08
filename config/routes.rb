Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/public_recipes', to: 'recipes#public_recipes'

  resources :foods, only: [:index, :new, :create]

  resources :users, only: %i[index show] do
    resources :recipes, only: %i[index show update] do
      resources :recipe_foods, only: %i[index show]
    end
  end
  delete 'foods/:id', to: 'foods#delete', as: 'delete_food'
end
