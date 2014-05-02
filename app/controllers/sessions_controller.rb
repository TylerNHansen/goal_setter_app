class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(user_params)
      flash.now[:errors] = ["Username and/or password is incorrect!"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
