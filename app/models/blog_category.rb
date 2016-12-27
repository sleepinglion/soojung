require 'carrierwave/orm/activerecord'

class BlogCategory < ActiveRecord::Base
  validates_presence_of :title
  validates_length_of :title, :minimum => 1, :maximum => 60, :allow_blank => true  
  belongs_to :blog_category
  belongs_to :user, :autosave=>true
  has_many :blog_category, :dependent=>:destroy
  has_many :blog, :dependent=>:destroy
#  translates :title
end
