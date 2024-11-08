Rails.application.routes.draw do
  resources :comments, only: :destroy
  resources :articles do
    resources :comments, only: :create
  end
  devise_for :users
  root to: "articles#index"

  namespace :api do
    resources :articles, except: %i[new edit] do
      resources :comments, only: :create
    end
    resources :comments, only: :destroy

    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
