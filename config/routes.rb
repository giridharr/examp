Rails.application.routes.draw do
  resources :pages
  devise_for :users
  resources :books
  resources :users
  root "books#index"
  get "books/book_html"
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
