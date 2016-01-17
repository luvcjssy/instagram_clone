class HashtagsController < ApplicationController

  def index
    @hashtags = SimpleHashtag::Hashtag.all
  end

  def show
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    @hashtagged = @hashtag.hashtaggables if @hashtag
    @posts = []
    @post_ids = []
    @hashtagged.each do |hashtag|
      if hashtag.class.method_defined? :post_id
        unless @post_ids.include? hashtag.post_id
          @post_ids.push(hashtag.post_id)
          @posts.push(hashtag.post)
        end
      else
        unless @post_ids.include? hashtag.id
          @post_ids.push(hashtag.id)
          @posts.push(hashtag)
        end
      end
    end
  end

end
