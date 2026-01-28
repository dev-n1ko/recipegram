Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "users/sessions"}
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"
  resources :users

  resources :recipes do
    resources :comments, only: [:create, :destroy]
  end
end
