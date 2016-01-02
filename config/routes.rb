Soblog::Application.routes.draw do
  root :to => "articles#index"
  resources :articles do
    member do
       put 'upvote'
       put 'downvote'
    end
    resources :comments 

  end 
  resources :profile
  resources :users
  resource :session
  get '/login' => "sessions#new", :as => "login"
  get '/logout' => "sessions#destroy", :as => "logout"
  resources :categories
end
