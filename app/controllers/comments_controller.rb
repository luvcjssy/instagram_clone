class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :find_comment, only: [:destroy]
  before_action :owned_comment, only: [:destroy]

  def index
    @comments = @post.comments.order('created_at')

    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def owned_comment
    unless current_user == @comment.user
      flash[:alert] = "That comment doesn't belongs to you!"
      redirect_to root_path
    end
  end
end
