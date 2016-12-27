class GuestBookComment < ActiveRecord::Base
  include AnonBoard  
  validates_presence_of  :content
  belongs_to :guest_book, :autosave=>true, :counter_cache=>true
  belongs_to :user, :autosave=>true
  accepts_nested_attributes_for :guest_book, :allow_destroy => true
end
