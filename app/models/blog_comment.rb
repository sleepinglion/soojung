require 'carrierwave/orm/activerecord'

class BlogComment < ActiveRecord::Base 
  include AnonBoard  
  validates_presence_of :content
  belongs_to :user, :autosave=>true  
  belongs_to :blog, :autosave=>true
#  translates :title, :content  
  mount_uploader :photo, BlogCommentUploader
end
