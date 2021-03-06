class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      if @user.save
        redirect_to admin_users_path
      end
    else
      render :edit
    end
  end


  def destroy
    @user = User.find(params[:id])
    UserMailer.delete_email(@user).deliver
    @user.destroy
    redirect_to admin_users_path
  end


  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin )
  end
end
