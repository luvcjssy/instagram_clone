class Comment < ActiveRecord::Base
	include SimpleHashtag::Hashtaggable

	hashtaggable_attribute :content

	belongs_to :user
	belongs_to :post
end
