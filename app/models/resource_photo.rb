# encoding: utf-8

require 'carrierwave/orm/activerecord'

class ResourcePhoto < ActiveRecord::Base
  validates_presence_of :photo, :alt
  belongs_to :resource, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :resource, :allow_destroy => true  
  mount_uploader :photo, ResourceUploader  
end
