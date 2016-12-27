# encoding: utf-8

require 'carrierwave/orm/activerecord'

class UserImage < ActiveRecord::Base
  validates_presence_of :image, :alt
  belongs_to :user, :autosave=>true
  accepts_nested_attributes_for :user, :allow_destroy => true  
  mount_uploader :image, UserImageUploader  
end
