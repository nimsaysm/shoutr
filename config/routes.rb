Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: "dashboards#show", as: :authenticated_root
  end

  root to: "homes#show"

  post "text_shouts" => "shouts#create", defaults: { content_type: TextShout }
  post "photo_shouts" => "shouts#create", defaults: { content_type: PhotoShout }

  resources :shouts, only: [:show] do
    member do
      post "like" => "likes#create"
      delete "unlike" => "likes#destroy"
    end
  end

  resources :hashtags, only: [:show]

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, only: [:create]

  resources :users, only: [:create, :show] do
    resources :followers, only: [:index]
    member do
      post "follow" => "followed_users#create"
      delete "unfollow" => "followed_users#destroy"
      get "followed_users" => "followed_users#index"
    end
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :edit, :update]
  end

  resource :search, only: [:show]

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
