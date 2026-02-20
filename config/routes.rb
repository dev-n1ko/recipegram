Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "users/sessions"}
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"
  resources :users do
    member do
      get :favorites
      post :follow
      delete :unfollow
      get :following
      get :followers
    end
  end

  resources :recipes do
    resources :comments, only: [:create, :destroy]
    resources :memos, only: [:create, :update]
    resource :favorite, only: [:create, :destroy]
  end
end
