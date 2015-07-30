require "tempfile"

class ProgramsController < ApplicationController
  before_action :set_program, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    params[:user_id] = params[:student_id] unless params[:user_id]
    params[:student_id] = params[:user_id] unless params[:student_id]
    @title = "Programmes" + (params[:user_id] ? " de l'étudiant: " + User.find_by_id(params[:user_id]).name : "")
    programs_table = Arel::Table.new(:programs)
    if current_user.try(:has_role?, :admin) || current_user.try(:has_role?, :teacher)
      @programs = Program.visible_for(current_user)
      if params[:user_id]
        @programs = @programs.where(user_id:  params[:user_id])
        if params[:course_id]
          @programs = @programs.where(programs_table[:mission_id].in Mission.joins(:chapter_mission_manifests).where(Arel::Table.new(:chapter_mission_manifests)[:chapter_id].in Course.find_by_id(params[:course_id]).chapters.map(&:id)).map(&:id))
        end
      end
    else
      @programs = Program.for_user(current_user)
    end
    @programs.each { |p| authorize_action_for p }
  end

  def show
    @title = "Programme : #{@program.mission_title}"
    render layout:  "snap"
  end

  def new
    @title = "Créer un programme"
    @program = Program.new
  end

  def edit
    @title = "Modifier le programme : #{@program.mission_title}"
  end

  def create
    @program = Program.new(program_params)
    authorize_action_for @program
    if @program.save
      redirect_to @program, notice: "Le programme a bien été créé."
    else
      @title = "Créer un programme"
      render :new
    end
  end

  def update
    @program.attributes = program_params
    authorize_action_for @program
    respond_to do |format|
      format.html do
        if @program.save
          redirect_to @program, notice: "Le programme a bien été mis à jour."
        else
          @title = "Modifier le programme : #{@program.mission_title}"
          render :edit
        end
      end
      format.json do
        if @program.save
          render :show
        end
      end
    end
  end

  def destroy
    authorize_action_for @program
    @program.destroy
    redirect_to programs_url, notice: "Le programme a bien été supprimé."
  end

  private
    def set_program
      @program = Program.find(params[:id])
      authorize_action_for @program
    end

    def program_params
      p = params.require(:program).permit(:source_code, :user_id, :mission_id, :state)
      if p[:source_code].instance_of?(String)
        name = ["program-#{p[:user_id]}-#{p[:mission_id]}",".xml"] # TODO user and mission id not present
        file = Tempfile.new(name, "#{Rails.root}/tmp")
        file.write(p[:source_code])
        file.rewind
        p[:source_code] = file
      end
      p
    end
end
