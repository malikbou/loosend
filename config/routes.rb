Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :toilets, only: [:index, :show] do
    resources :reviews, only: [:index, :new, :create]
  end
  resources :reviews, only: [:show, :edit, :update, :destroy]

  # Naked Domain redirected to www
  # match "(*any)", to: redirect(subdomain: ""), via: :all, constraints: { subdomain: "www" }
end
