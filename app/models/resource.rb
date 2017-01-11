# encoding: utf-8

require 'carrierwave/orm/activerecord'

class Resource < ActiveRecord::Base
  validates_presence_of :title, :controller
  has_one :resource_photo, :foreign_key => :id, :dependent => :destroy
  accepts_nested_attributes_for :resource_photo, :allow_destroy => true
  
  def order
    if self.desc
      return 'id desc'
    else
      return 'id asc'
    end
  end
end
