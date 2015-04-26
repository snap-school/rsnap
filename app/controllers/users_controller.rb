class UsersController < ApplicationController
  authorize_actions_for User
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except=>[:new, :create]

  def index
    @title = "Utilisateurs"
    @users = User.all.order(:id)
    @users.find_each {|u| authorize_action_for u}
  end

  def show
    @title = "utilisateur : #{@user.name}"
    if params[:id]
      set_user
    else
      @user = current_user
    end
    authorize_action_for @user
  end

  def new
    @title = "Créer un utilisateur"
    @user = User.new
  end

  def edit
    @title = "Modifier l'utilisateur : #{@user.name}"
    render "devise/registrations/edit"
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "L'utilisateur a bien été créé."
    else
      @title = "Créer un utilisateur"
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "L'utilisateur a bien été mis à jour."
    else
      @title = "Modifier l'utilisateur : #{@user.name}"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "L'utilisateur a bien été supprimé."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      authorize_action_for @user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end
end
