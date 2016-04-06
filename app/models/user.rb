class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
          #:confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :links, dependent: :destroy

  # auth polymorphic
  has_many :entries, dependent: :destroy

  #has_many :entry_elements, as: :elements
  #has_many :entry_elements, dependent: :destroy

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  before_create :build_profile

  # no need to validate unique email - devise sorted this out already
  #validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  # what has user voted for?
  acts_as_voter
  
  #def username
    #self.email.split(/@/).first
  #end

  #def to_param
    #{}"#{id} #{username}".to_slug.normalize.to_s
  #end
end
