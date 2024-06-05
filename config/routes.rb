Rails.application.routes.draw do
  get 'terms_of_service', to: 'static_pages#terms_of_service', as: 'terms_of_service'
  get 'privacy', to: 'static_pages#privacy'
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks" ,
    registrations: "users/registrations"
  }

  get 'users/auth/google_oauth2/callback', to: 'users/omniauth_callbacks#google_oauth2'
  get 'users/auth/line/callback', to: 'users/omniauth_callbacks#line'

  get 'sessions/new'
  root "top#index"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get 'static_pages/terms_of_service', to: 'static_pages#terms_of_service'
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search" , to: "searches#index"

  resources :users
  resource :profile, only: [:show, :edit, :update]
  resources :boards do
    collection do
      post 'search'
      get 'bookmarks'
      get 'ranking'
    end
    resources :comments, only: [:index, :create, :update, :edit, :destroy], shallow: true
    post 'rate', on: :member

    resources :reviews, only: [:create, :destroy], shallow: true
  end
  
  resources :reviews, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
  resources :surveys, only: [:new, :create, :show]
  get '*path', to: 'application#render404'
  get '*path', to: 'application#render500'
end
