Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'dashboard/index'
  resources :user, only: [:create, :show, :update, :destroy]
  get 'time_reg/index/:day_id', to: 'time_reg#index'
  get 'add_entry', to: 'time_reg#add_entry'
  post 'register_entry', to: 'time_reg#register_entry'
  resources :time_reg, only: [:show, :create, :update, :destroy]
  resources :day, only: [:index, :show]

  get '*clocks', to: 'home#index'
end
