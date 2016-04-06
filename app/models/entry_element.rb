class EntryElement < ActiveRecord::Base
  belongs_to :entry
  belongs_to :element, :polymorphic => true
end
