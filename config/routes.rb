Rails.application.routes.draw do
  root 'home#index'
  get "/help", to: "home#help"
  get "/home/crawl", to: "home#crawl"
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  resources  :users,    only: :show
  resources  :products, only: [:create, :show, :update, :destroy]
  post "/update_all_products", to: "products#update_all"

  # action cable
  mount ActionCable.server => '/cable'
end
