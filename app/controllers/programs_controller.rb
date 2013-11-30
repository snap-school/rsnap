class ProgramsController < ApplicationController
  before_action :set_program, only: [:show, :edit, :update, :destroy]

  def index
    @programs = Program.all
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

    if @program.save
      redirect_to @program, notice: 'Program was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @program.update(program_params)
      redirect_to @program, notice: 'Program was successfully updated.'
    else
      render action: 'edit'
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.require(:program).permit(:source_code, :user_id)
    end
end
