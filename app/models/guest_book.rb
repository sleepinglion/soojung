class GuestBook < ActiveRecord::Base
  is_impressionable
  include AnonBoard
  validates_presence_of :title
  validates_length_of :title, :minimum => 4, :maximum => 60, :allow_blank => true  
  has_one :guest_book_content, :foreign_key => :id, :dependent => :destroy
  has_many :guest_book_comment, :dependent=> :destroy
  belongs_to :user, :autosave=>true
  accepts_nested_attributes_for :guest_book_content, :allow_destroy => true
  accepts_nested_attributes_for :guest_book_comment, :allow_destroy => true
end