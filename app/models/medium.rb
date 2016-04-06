class Medium < ActiveRecord::Base
  belongs_to :mediumable, :polymorphic => true
  has_one :entry
end
