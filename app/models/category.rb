class Category < ActiveRecord::Base
	#has_many :links
  has_many :entries
  has_many :media, as: :mediumable

  #accepts_nested_attributes_for :medium
end
