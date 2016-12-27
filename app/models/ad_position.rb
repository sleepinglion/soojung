# encoding: utf-8

class AdPosition < ActiveRecord::Base
  validates_presence_of :title
end
