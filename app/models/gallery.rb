require 'carrierwave/orm/activerecord'

class Gallery < ActiveRecord::Base
  validates_presence_of :title, :photo
  validates_length_of :title, :minimum => 4, :maximum => 60, :allow_blank => true  
  belongs_to :user, :autosave => true  
  belongs_to :gallery_category, :autosave => true, :counter_cache => true
#  translates :title, :location, :content  
  mount_uploader :photo, GalleryUploader
end
