Rails.application.routes.draw do
  resources :elements
  resources :groups
  mount_devise_token_auth_for 'User', at: 'auth'
end
