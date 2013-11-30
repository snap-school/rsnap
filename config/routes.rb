Rsnap::Application.routes.draw do
  resources :programs

  resources :file_missions

  resources :missions
  resources :program_mission_initializations, :only=>:new

  devise_for :users
  resources :users

  root :to => "home#index"
end
