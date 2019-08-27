Rails.application.routes.draw do
  root 'home#top'
#  root 'books#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :books
  resources :users, only: [:index, :show, :edit, :update]
  get 'home/about', to: 'home#about'
end