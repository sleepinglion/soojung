class BlogContent < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :blog, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :blog, :allow_destroy => true
#  translates :content  
end
