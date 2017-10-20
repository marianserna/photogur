class UsersController < ApplicationController
  skip_before_action :ensure_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "#{@user.email} has been saved!"
      session[:user_id] = @user.id
      redirect_to pictures_url
    else
      flash[:alert] = "Please fix errors"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
