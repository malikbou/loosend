Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :toilets, only: [:index, :show] do
    resources :reviews, only: [:new, :show, :create, :edit, :update, :destroy]
  end
  # Defines the root path route ("/")
  # root "articles#index"
  # get "review_confirmation/:id", to "reviews#show"
end
