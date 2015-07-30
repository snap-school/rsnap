require "tempfile"

class ProjectsController < ApplicationController
  authorize_actions_for Project
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @title = "Projets"
    if current_user and current_user.try(:has_role?, :admin)
      @projects = Project.all
    else
      @projects = Project.for_user(current_user)
    end
    @projects.find_each { |p| authorize_action_for p }
  end

  def show
    respond_to do |format|
      format.html do
        @title = "Projet : #{@project.name}"
        render :layout => "snap"
      end
      format.json do
        render :show
      end
    end
  end

  def new
    @title = "Créer un projet"
    render :layout => "snap"
    @project = Project.new
  end

  def edit
    @title = "Modifier le projet : #{@project.name}"
  end

  def create
    @project = Project.new(project_params)
    authorize_action_for @project
    if @project.save
      respond_to do |format|
        format.json do
          render :show
        end
      end
    else
      render @project.errors.full_messages
    end
  end

  def update
    @project.attributes = project_params
    authorize_action_for @project
    respond_to do |format|
      format.html do
        if @project.save
          render :layout => "snap"
          redirect_to @project, notice: "Le projet a bien été mis à jour."
        else
          @title = "Modifier le project : #{@project.name}"
          render :edit
        end
      end
      format.json do
        if @project.save
          render :show
        end
      end
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: "Le projet a bien été supprimé"
  end

  private
    def set_project
      @project = Project.find(params[:id])
      authorize_action_for @project
    end

    def project_params
      p = params.require(:project).permit(:source_code, :user_id, :name)
      if p[:source_code].instance_of?(String)
        name = ["project-#{p[:user_id]}-#{p[:name]}",".xml"] # TODO user and mission id not present
        file = Tempfile.new(name, "#{Rails.root}/tmp")
        file.write(p[:source_code])
        file.rewind
        p[:source_code] = file
      end
      p[:user_id] = current_user.id unless p[:user_id]
      p
    end
end
