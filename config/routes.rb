Rails.application.routes.draw do
  root 'home#index'
  get "/help", to: "home#help"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources  :users,    only: :show
  resources  :products, only: [:create, :show, :update, :destroy]
  post "/update_all_products", to: "products#update_all"
end
