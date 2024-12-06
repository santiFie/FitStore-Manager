Rails.application.routes.draw do
  # Routes for resources
  resources :sales
  resources :clients

  # Routes for Devise
  devise_for :users, skip: :registrations, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  resources :users do
    patch :block, on: :member
    patch :unblock, on: :member
  end

  # Routes for products
  resources :products

  # Additional routes
  get "search", to: "home#index"  # Route for search

  # Application health check route (optional)
  get "up" => "rails/health#show", as: :rails_health_check

  # Define the root of the application
  root "products#index"
end
