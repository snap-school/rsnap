Rsnap::Application.routes.draw do

  # post from Snap saying the mission has been accomplished and destroy from programs list
  resources :solved_missions, :only=>[:create,:destroy] 

  resources :chapters do
    # showing (index) and adding (post - create) missions of/to a chapter
    resources :missions, :only=>[:index, :create], :controller => :chapter_missions, path_names: {create: 'add_mission'}

    # showing list of missions that can be added to the chapter
    resources :missions, :only=>[:new], path_names: {new: 'add_mission'}, :controller => :missions
  end

  resources :sort_chapters, :only=>:update

  # destroying a chapter_mission_manifest = removing a mission from a chapter
  resources :chapter_mission_manifest, :only => [:destroy]

  resources :programs

  resources :file_missions

  resources :missions
  resources :mission_programs, :only=>[:show, :update]
  resources :sort_missions, :only=>:update
  resources :initialization_program_missions, :only=>[:new]

  resources :projects

  devise_for :users, :path => "auth", :controllers => { :registrations => "registrations" }
  resources :users do
    resources :programs, only: [:index]
  end

  resources :snap_assets, :only=>:index

  resources :home, :only=>:index do
    collection do
      get :about
      get :after_missions_form
      get :welcome
      get :thanks
    end
  end
  root :to => "home#index"
end
