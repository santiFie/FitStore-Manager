Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "search", to: "home#index"

  # config/routes.rb
  Rails.application.routes.draw do
    devise_for :users, skip: :registrations, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
    resources :users do
      patch :block, on: :member
      patch :unblock, on: :member
    end

    # resources :products do
    #   delete :delete_image, on: :member
    # end
    resources :products
  end
  root "products#index" # Define la raíz de la aplicación
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
