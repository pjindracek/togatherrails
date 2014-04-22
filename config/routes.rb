Togather::Application.routes.draw do

  devise_for :users
  root to: 'welcome#index'

  get '/user', to: 'users#profile', as: 'profile'
  get '/profile/:id', to: 'users#profile', as: 'user'
  get '/profile', to: 'users#profile', as: 'user_root'

  resources :groups do
    resources :comments, only: [:create]
  end
  post '/groups/register/:id', to: 'groups#register', as: 'register'
  post '/groups/unregister/:id', to: 'groups#unregister', as: 'unregister'

end
