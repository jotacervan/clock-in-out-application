Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'dashboard/index'
  resources :user, only: [:create, :show, :update, :destroy]
  get 'time_reg/index/:day_id', to: 'time_reg#index'
  resources :time_reg, only: [:show, :create, :update, :destroy]

  get '*clocks', to: 'home#index'
end
