Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Pay webhooks
  mount Pay::Engine, at: "/pay"

  # Sidekiq Web UI (password protected)
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # Home and Dashboard
  root "home#index"
  get "dashboard" => "home#dashboard"

  # Billing routes
  resources :billing, only: [:show, :update] do
    member do
      get :checkout
      post :create_checkout_session
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
