# encoding: utf-8

class IntroPhoto < ActiveRecord::Base
  validates_presence_of :title
end
