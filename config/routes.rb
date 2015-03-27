Rails.application.routes.draw do
  resources :topics do
    resources :posts
  end

  resources :users, only: [:index, :destroy] do
    collection do
      patch 'sync', to: 'users#sync', as: :sync
    end
  end
  
  root :to => "topics#index", constraints: lambda{|request| request.session[:user].present? }
  root to: 'sessions#index', as: :visitor_root
end
