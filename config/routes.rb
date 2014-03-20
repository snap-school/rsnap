Rsnap::Application.routes.draw do
  resources :programs

  resources :file_missions

  resources :missions
  resources :mission_programs, :only=>[:show, :update]
  resources :sort_missions, :only=>:update
  resources :initialization_program_missions, :only=>[:new, :update]

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
