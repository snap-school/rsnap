require 'tempfile'

class ProgramsController < ApplicationController
  authorize_actions_for Program
  before_action :set_program, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @title = "Programmes"
    if params[:all]
      @programs = Program.all
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
      redirect_to @program, notice: 'Program was successfully created.'
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
          redirect_to @program, notice: 'Program was successfully updated.'
        else
          @title = "Modifier le programme : #{@program.mission_title}"
          render :edit
        end
      end
      format.json do
        if @program.save
          render :show
        else
          render :json => { :errors => @program.errors.full_messages }
        end
      end
    end
  end

  def destroy
    @program.destroy
    redirect_to programs_url
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
