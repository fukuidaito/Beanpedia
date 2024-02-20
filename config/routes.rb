Rails.application.routes.draw do
  devise_for :users
  get 'sessions/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "top#index"
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get  "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users
  resource :profile, only: %i[show edit update]
  resources :boards do
    resources :comments, only: %i[create], shallow: true
    collection do
			get 'bookmarks'
      get 'ranking'
		end
  end
  resources :bookmarks, only: %i[create destroy]
end
