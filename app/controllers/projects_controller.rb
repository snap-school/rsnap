require 'tempfile'

class ProjectsController < ApplicationController
  authorize_actions_for Project
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @title = "Projets"
    if params[:all]
      @projects = Project.all
    else
      @projects = Project.for_user(current_user)
    end
    @projects.each {|p| authorize_action_for p}
  end

  def show
    @title = "Projet : #{@project.name}"
    render :layout=>"snap"
  end

  def new
    @title = "Créer un projet"
    @project = Project.new
  end

  def edit
    @title = "Modifier le projet : #{@project.name}"
  end

  def create
    @project = Project.new(project_params)
    authorize_action_for @project
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      @title = "Créer un projet"
      render :new
    end
  end

  def update
    @project.attributes = project_params
    authorize_action_for @project
    respond_to do |format|
      format.html do
        if @project.save
          redirect_to @project, notice: 'Project was successfully updated.'
        else
          @title = "Modifier le project : #{@project.name}"
          render :edit
        end
      end
      format.json do
        if @project.save
          render :show
        else
          render :json => { :errors => @project.errors.full_messages }
        end
      end
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url
  end

  private
    def set_project
      @project = Project.find(params[:id])
      authorize_action_for @project
    end

    def project_params
      p = params.require(:project).permit(:source_code, :user_id, :name)
      if p[:source_code].instance_of?(String)
        name = ["project-#{p[:user_id]}-#{p[:name]}",".xml"] #TODO user and mission id not present
        file = Tempfile.new(name, "#{Rails.root}/tmp")
        file.write(p[:source_code])
        file.rewind
        p[:source_code] = file
      end
      p
    end
end
