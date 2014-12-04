Rails.application.routes.draw do
  resources :topics do
    resources :posts
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signin' => 'sessions#new', as: :signin
  delete '/signout' => 'sessions#destroy', as: :signout
  get '/idle' => 'sessions#idle', as: :idle
  get '/signout' => 'sessions#destroy'
  get '/auth/failure' => 'sessions#failure'
  
  resources :users, only: [:index, :destroy] do
    collection do
      patch 'sync', to: 'users#sync', as: :sync
    end
  end
  
  root :to => "topics#index", constraints: lambda{|request| request.session[:user].present? }
  root to: 'sessions#index', as: :visitor_root
end
