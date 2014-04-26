Togather::Application.routes.draw do

  #devise_for :users, skip: [:cancel]

  devise_for :users, skip: :registrations
  devise_scope :user do # will disable cancelling the account
  resource :registration,
             only: [:new, :create, :edit, :update],
             path: 'users',
             path_names: { new: 'sign_up' },
             controller: 'devise/registrations',
             as: :user_registration do
              get :cancel
             end
  end

  root to: 'welcome#index'

  get '/user', to: 'users#profile', as: 'profile'
  get '/profile/:id', to: 'users#profile', as: 'user'
  get '/profile', to: 'users#profile', as: 'user_root'

  resources :groups, except: [:index] do
    resources :comments, only: [:create]
    resources :events, except: [:index]
  end
  post '/groups/register/:id', to: 'groups#register', as: 'register'
  post '/groups/unregister/:id', to: 'groups#unregister', as: 'unregister'

  post '/groups/:group_id/events/:id/register', to: 'events#register', as: 'event_register'
  post '/groups/:group_id/events/:id/unregister', to: 'events#unregister', as: 'event_unregister'

  get '/search', to: 'groups#search', as: 'search'
end
