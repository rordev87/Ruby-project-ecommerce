Rails.application.routes.draw do
   namespace :admin do
    root "admin/users#index"
    resources :users
  end
  namespace :admin do
    root "admin/categories#index"
    resources :categories
  end

  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  post "/rating", to: "ratings#update"

  get "/carts", to: "carts#index"
  get "/cart", to: "carts#show"
  post "/new_cart", to: "carts#create"
  post "/update_cart", to: "carts#update"
  delete "destroy_cart", to: "carts#destroy"

  resources :users
  resources :account_activations, only: :edit
  resources :ratings, only: :update
  resources :products
  resources :orders
  resources :categories
  resources :carts, only: :show
  resources :order_details, only: [:create, :update, :destroy]

end
