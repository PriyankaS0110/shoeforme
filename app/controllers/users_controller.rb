class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]

  def index
    @users = User.find_each
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path , notice: 'User has been created Successfully'
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show  #admin 

  end  

  def destroy  #admin
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: "user was successfully destroyed." }
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :phone_number, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
