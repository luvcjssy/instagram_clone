class HashtagsController < ApplicationController

  def index
    @hashtags = SimpleHashtag::Hashtag.all
  end

  def show
    # Get hashtag after click
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])

    # Get all posts and comments contain that hashtag
    @hashtagged = @hashtag.hashtaggables if @hashtag

    # It contains all posts that have hashtag
    @posts = []

    # Use to check post_id has exist in array
    post_ids = []

    # Check hashtag belongs to Post or Comment
    # If hashtag belongs to Comment (It contains post_id field)
    # get post_id and post, after push into array posts
    # If hashtag belongs to Post, just push that hashtag object into array posts
    @hashtagged.each do |hashtag|
      if hashtag.class.method_defined? :post_id
        unless post_ids.include? hashtag.post_id
          post_ids.push(hashtag.post_id)
          @posts.push(hashtag.post)
        end
      else
        unless post_ids.include? hashtag.id
          post_ids.push(hashtag.id)
          @posts.push(hashtag)
        end
      end
    end
  end
end
