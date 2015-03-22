Rsnap::Application.routes.draw do
  resources :chapters
  resources :sort_chapters, :only=>:update

  post '/chapter_missions/:chapter_id/add_mission/:mission_id', to:'chapter_mission_manifest#create'
  get '/chapter_missions/:id/add_mission/', to:'missions#index'

  resources :chapter_missions, :only=>[:show,:update,:index,:destroy]
  resources :chapter_mission_manifest, :only => [:destroy]

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
      get :welcome
    end
  end
  root :to => "home#index"
end
