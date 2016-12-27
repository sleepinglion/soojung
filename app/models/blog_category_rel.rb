# encoding: utf-8

require 'carrierwave/orm/activerecord'

class BlogCategoryRel < ActiveRecord::Base
  validates_presence_of :blog_category_id, :blog_category_rel_id
  belongs_to :blog_category, :dependent=>:delete, :autosave=>true
  belongs_to :blog_category, :dependent=>:delete, :foreign_key => :blog_category_rel_id, :autosave=>true
end
