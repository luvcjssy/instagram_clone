class Post < ActiveRecord::Base
	include SimpleHashtag::Hashtaggable
	hashtaggable_attribute :title

	acts_as_votable
	
	validates :user_id, presence: true
	validates :image, presence: true
	belongs_to :user
	has_many :comments, dependent: :destroy
	
	has_attached_file :image, styles: { medium: "300x300>", :large => "500x500>" }
	crop_attached_file :image
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
