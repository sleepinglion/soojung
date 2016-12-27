class Tag < ActiveRecord::Base
  is_impressionable
  validates_presence_of :title
  validates_length_of :title, :minimum => 4, :maximum => 60, :allow_blank => true  
  belongs_to :user, :autosave=>true
end
