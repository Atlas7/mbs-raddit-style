class Link < ActiveRecord::Base
	acts_as_commentable
	acts_as_votable

	belongs_to :user
	#belongs_to :category
	
	has_many :comments, as: :commentable
	#has_many :comments

	#validates :category, presence: true


	def score
  	self.get_upvotes.size - self.get_downvotes.size
  end

end
