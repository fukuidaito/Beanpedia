Rails.application.routes.draw do
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks" ,
    registrations: "users/registrations"
  }

  get 'sessions/new'
  root "top#index"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search" , to: "searches#index"

  resources :users
  resource :profile, only: [:show, :edit, :update]
  resources :boards do
    resources :comments, only: [:create], shallow: true
    post 'rate', on: :member
    collection do
      get 'bookmarks'
      get 'ranking'
    end
  end
  resources :bookmarks, only: [:create, :destroy]
  resources :surveys, only: [:new, :create, :show]
end
