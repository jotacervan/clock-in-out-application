Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'dashboard/index'
  resources :user, only: [:create, :show, :update, :destroy]

  get '*clocks', to: 'home#index'
end
