class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :find_post, only: [:show, :edit, :update, :destroy, :like]
	before_action :owned_post, only: [:edit, :update, :destroy]
	
	def index
		@posts = Post.all.order('created_at DESC').page params[:page]
	end

	def show
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			flash[:success] = "Successfully created new Post!"
			redirect_to @post
		else
			flash.now[:alert] = "Create new Post failed!"
			render 'new'
		end 
	end

	def edit
	end

	def update
		if @post.update(post_params)
			flash[:success] = "Post was successfully updated!"
			redirect_to @post
		else
			flash.now[:alert] = "Update Post failed!"
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	def like
		if @post.liked_by current_user
			respond_to do |format|
				format.html { redirect_to :back }
				format.js
			end
		end
	end

	private

	def post_params
		params.require(:post).permit(:title, :image)
	end
	
	def find_post
		@post = Post.find(params[:id])
	end

	def owned_post
		unless current_user == @post.user
			flash[:alert] = "That post doesn't belongs to you!"
    		redirect_to root_path
		end
	end
end
