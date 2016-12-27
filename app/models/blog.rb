require 'carrierwave/orm/activerecord'

class Blog < ActiveRecord::Base
  is_impressionable
  acts_as_taggable
  validates_presence_of :title, :description
  validates_length_of :title, :minimum => 4, :maximum => 60, :allow_blank => true  
  belongs_to :user, :autosave=>true
  belongs_to :blog_category, :autosave=>true, :counter_cache => true
  has_one :blog_content, :foreign_key => :id, :dependent => :destroy
  has_many :blog_comment, :dependent=>:destroy
  accepts_nested_attributes_for :blog_content, :allow_destroy => true
  accepts_nested_attributes_for :blog_comment, :allow_destroy => true
#  translates :title, :description
  mount_uploader :photo, BlogUploader
  
  def tag_list
    self.tags.map(&:name).join(', ')
  end 
end
