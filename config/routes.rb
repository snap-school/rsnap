Rsnap::Application.routes.draw do
  resources :chapters
  post '/chapter_missions/:id/add_mission/:mission_id', to:'chapters#update'
  get '/chapter_missions/:id/add_mission/', to:'missions#index'
  post '/chapters/:id/remove_mission/:mission_id', to:'chapters#destroy'

  resources :chapter_missions, :only=>[:show,:update,:index,:destroy]

  resources :programs

  resources :file_missions

  resources :missions
  resources :mission_programs, :only=>[:show, :update]
  resources :sort_missions, :only=>:update
  resources :initialization_program_missions, :only=>[:new]

  resources :projects

  devise_for :users, :path => "auth", :controllers => { :registrations => "registrations" }
  resources :users

  resources :snap_assets, :only=>:index

  resources :home, :only=>:index do
    collection do
      get :about
      get :after_missions_form
    end
  end
  root :to => "home#index"
end
