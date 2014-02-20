Rsnap::Application.routes.draw do
  resources :programs

  resources :file_missions

  resources :missions
  resources :sort_missions, :only=>:update
  resources :initialization_program_missions, :only=>:new

  devise_for :users, :path => "auth", :controllers => { :registrations => "registrations" }
  resources :users

  resources :snap_assets, :only=>:index

  root :to => "home#index"
end
