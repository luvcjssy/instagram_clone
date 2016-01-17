class ProfilesController < ApplicationController
  before_action :find_user

  def show
  	@posts = @user.posts.order('created_at DESC')
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
  end

end
