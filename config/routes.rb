Rsnap::Application.routes.draw do
  resources :programs

  resources :file_missions

  resources :missions
  resources :ides, :only=>:show

  devise_for :users
  resources :users

  root :to => "home#index"
end
