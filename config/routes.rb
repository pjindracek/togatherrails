Togather::Application.routes.draw do

  devise_for :users
  root to: 'welcome#index'

  get 'user', to: 'users#profile', as: 'profile'
  get 'profile', to: 'users#profile', as: 'user_root'

  resources :groups
  post '/groups/register/:id', to: 'groups#register', as: 'register'
end
