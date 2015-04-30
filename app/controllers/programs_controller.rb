require "tempfile"

class ProgramsController < ApplicationController
  authorize_actions_for Program
  before_action :set_program, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @title = "Programmes"
    if current_user.has_role(:admin) #if params[:all]s[:all]
      if params[:user_id]
        @programs = []
        Mission.ordered_using_chapters().find_each do |m|
          @programs.append(Program.find_by(:user_id => params[:user_id], :mission_id => m.id)) if not Program.find_by(:user_id => params[:user_id], :mission_id => m.id).nil?
        end
      else
        @programs = Program.all
      end
    else
      @programs = Program.for_user(current_user)
    end
    @programs.each {|p| authorize_action_for p}
  end

  def show
    @title = "Programme : #{@program.mission_title}"
    render :layout=>"snap"
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
    m = SolvedMission.where(:mission_id=>@program.mission_id,:user_id=>current_user.id).first
    m.destroy if not m.nil?
    @program.destroy
    redirect_to programs_url, notice: "Le programme a bien été supprimé."
  end

  private
    def set_program
      @program = Program.find(params[:id])
      authorize_action_for @program
    end

    def program_params
      p = params.require(:program).permit(:source_code, :user_id, :mission_id)
      if p[:source_code].instance_of?(String)
        name = ["program-#{p[:user_id]}-#{p[:mission_id]}",".xml"] #TODO user and mission id not present
        file = Tempfile.new(name, "#{Rails.root}/tmp")
        file.write(p[:source_code])
        file.rewind
        p[:source_code] = file
      end
      p
    end
end
