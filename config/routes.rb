Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/request/search_substring', to: 'request#search_substring'
  post '/request/new_request', to: 'request#create'
  get '/request/', to: 'request#index'
  delete '/request/delete_request', to: 'request#destroy'
end
