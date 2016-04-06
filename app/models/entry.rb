class Entry < ActiveRecord::Base
  acts_as_votable
  acts_as_commentable

  belongs_to :user
  belongs_to :category
  #belongs_to :mediumable, polymorphic: true
  belongs_to :medium

  has_one :entry_element, dependent: :destroy

  # has_many :comments, :through => :entry_elements, :source => :element, :source_type => 'Comment', dependent: :destroy

  # has_many :quotes, :through => :entry_elements, :source => :element, :source_type => 'Quote', dependent: :destroy
  # has_many :pictures, :through => :entry_elements, :source => :element, :source_type => 'Picture', dependent: :destroy

  has_one :quote, :through => :entry_element, :source => :element, :source_type => 'Quote', dependent: :destroy
  has_one :picture, :through => :entry_element, :source => :element, :source_type => 'Picture', dependent: :destroy

  accepts_nested_attributes_for :category

  validates :category, presence: true

  # voting related functions
  def vote_score
    self.get_upvotes.size - self.get_downvotes.size
  end

end
