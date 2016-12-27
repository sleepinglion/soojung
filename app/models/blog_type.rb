# encoding: utf-8

class BlogType < ActiveRecord::Base 
  validates_presence_of :title
  has_many :blog_category
end
