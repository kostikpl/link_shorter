Rails.application.routes.draw do
  resources :links, only: :create
  root 'links#new'
  match '/:short_url' => 'links#show', via: :get
end
