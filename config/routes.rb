Rails.application.routes.draw do
  unauthenticated do
    root 'pages#home'
  end
  authenticated :user do
    root 'items#index'
  end

  devise_for :users

  get '/about', to: 'pages#about'

  resources :items
end
