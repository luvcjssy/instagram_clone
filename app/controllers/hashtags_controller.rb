class HashtagsController < ApplicationController

  def index
    @hashtags = SimpleHashtag::Hashtag.all
  end

  def show
    # Use to check post_id has exist in array
    post_ids = []

    # Get hashtag after click
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    return Post.none if @hashtag.nil?

    # Get all posts and comments contain that hashtag
    @hashtagged = @hashtag.hashtaggables if @hashtag

    # Check hashtag belongs to Post or Comment
    # If hashtag belongs to Comment (It contains post_id field)
    # get post_id and push into array
    # If hashtag belongs to Post, just push that hashtag'id into array
    @hashtagged.each do |hashtag|
      if hashtag.class.method_defined? :post_id
        unless post_ids.include? hashtag.post_id
          post_ids.push(hashtag.post_id)
        end
      else
        unless post_ids.include? hashtag.id
          post_ids.push(hashtag.id)
        end
      end
    end

    @posts = Post.where(id: post_ids).order(created_at: :desc).page params[:page]
  end
end
