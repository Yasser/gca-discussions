Rails.application.routes.draw do
  resources :topics do
    resources :posts
  end

  mount GcaSsoClient::Engine => '/'
  root :to => "topics#index"
end
