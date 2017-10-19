Rails.application.routes.draw do

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  root 'pictures#index'

  resources :pictures
  resources :users, only: [:new, :create]
end
