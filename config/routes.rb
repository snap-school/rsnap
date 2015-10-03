Rsnap::Application.routes.draw do

  resources :course_inscription,    only: [:index, :create]
  resources :course_desinscription, only: [:index, :destroy]

  resources :courses do
    resources :chapters, only:  [:index, :create],  controller:  :course_chapters,  path_names: {create: 'add_chapter'}
    resources :chapters, only:  [:new],             controller:  :chapters,         path_names: {new:    'add_chapter'}, action: "add_chapter"
    resources :chapters, only:  [:show]

    resources :chapters do
      resources :missions, only:  [:index, :create], controller:  :chapter_missions, path_names: {create: 'add_mission'}
      resources :missions, only:  [:new],            controller:  :missions,         path_names: {new:    'add_mission'}, action: "add_mission"
      resources :missions, only:  [:show]
    end

    resources :students, only:  [:index], controller:  :users do
      resources :programs, only:  [:index]
    end
  end

  resources :course_chapter_manifest, only:  [:destroy]

  resources :chapters do
    resources :missions, only:  [:index, :create], controller:  :chapter_missions, path_names: {create: 'add_mission'}
    resources :missions, only:  [:new],            controller:  :missions,         path_names: {new:    'add_mission'}, action: "add_mission"
    resources :missions, only:  [:show]
  end

  resources :sort_chapters, only:  :update

  # destroying a chapter_mission_manifest = removing a mission from a chapter
  resources :chapter_mission_manifest, only:  [:destroy]

  resources :programs

  resources :file_missions

  resources :missions
  resources :mission_programs, only:  [:show, :update]
  resources :initialization_program_missions, only:  [:new]

  resources :projects

  devise_for :users, path:  "auth", controllers:  { registrations:  "registrations" }
  resources :users do
    resources :programs,  only:  :index
  end

  devise_for :admins, path:  "auth", only:  [:destroy]
  devise_for :teachers, path:  "auth", only:  [:destroy]

  resources :snap_assets, only:  :index

  resources :home, only:  :index do
    collection do
      get :about
      get :after_missions_form
      get :thanks
    end
  end
  root to:  "home#index"
end
