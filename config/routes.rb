Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources  :users,    only: :show
  resources  :products, only: [:create, :show, :update, :destroy]
end
