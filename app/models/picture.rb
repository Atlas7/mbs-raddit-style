class Picture < ActiveRecord::Base
  has_one :entry_element, :as =>:element, dependent: :destroy
  has_one :entry, :through => :entry_element, dependent: :destroy

  validates :title, presence: true

end
