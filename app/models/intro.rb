# encoding: utf-8

class Intro < ActiveRecord::Base
  validates_presence_of :title, :description
end
