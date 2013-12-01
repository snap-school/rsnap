class ProgramsController < ApplicationController
  authorize_actions_for Program
  before_action :set_program, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    if params[:all]
      @programs = Program.all
    else
      @programs = Program.for_user(current_user)
    end
    @programs.each {|p| authorize_action_for p}
  end

  def show
    render :layout=>"snap"
  end

  def new
    @program = Program.new
  end

  def edit
  end

  def create
    @program = Program.new(program_params)
    authorize_action_for @program
    if @program.save
      redirect_to @program, notice: 'Program was successfully created.'
    else
      render :new
    end
  end

  def update
    @program.attributes = program_params
    authorize_action_for @program
    if @program.save
      redirect_to @program, notice: 'Program was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @program.destroy
    redirect_to programs_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
      authorize_action_for @program
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.require(:program).permit(:source_code, :user_id, :mission_id)
    end
end
