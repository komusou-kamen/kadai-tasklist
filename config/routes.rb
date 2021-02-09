Rails.application.routes.draw do
  
  root to: 'tasks#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
    
  get 'signup', to: 'users#new'
  resources :users, only: [:new]
  #resources :users
  post 'signup', to: 'users#create'
  
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
