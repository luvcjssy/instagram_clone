class Post < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
	
  hashtaggable_attribute :title

  acts_as_votable

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :image, presence: true

  has_attached_file :image, styles: { medium: "300x300>", :large => "500x500>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  crop_attached_file :image
end
