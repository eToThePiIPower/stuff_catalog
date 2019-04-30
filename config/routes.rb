Rails.application.routes.draw do
  unauthenticated do
    root 'pages#home'
  end
  authenticated :user do
    root 'items#index'
  end

  devise_for :users

  get '/about', to: 'pages#about'

  resources :items do
    collection do
      post :lookup_new
    end
    member do
      put :lookup_edit
      patch :lookup_edit
    end
  end
end
