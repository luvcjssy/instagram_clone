class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :find_user

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated!'
      redirect_to profile_path(@user.user_name)
    else
      flash[:error] = 'Update your profile failed!'
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end

  def find_user
    @user = User.find_by(user_name: params[:user_name])

    unless @user
      flash[:alert] = "That user doesn't exist!"
      redirect_to root_path
    end
  end
end
