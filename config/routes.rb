Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :index, :show] do
          get :profile, action: :show
      end
      resources :sessions, only: :create
      namespace :viewing_parties do
        resources :invitations, only: :create, controller: :invitations, action: :create
      end
      resources :viewing_parties, only: [:create, :index]
      resources :movies, only: [ :index, :show ] do
        collection do
          get :top_rated, action: :index
          get :search, action: :index
          get :movie_details, action: :show
        end
      end
    end
  end
end
