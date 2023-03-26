Rails.application.routes.draw do
  resources :elements
  resources :groups
  mount_devise_token_auth_for 'User', at: 'auth'
  get '/groups', to: 'groups#index'
  get '/elements', to: 'elements#index'
end
