# encoding: utf-8

class QuestionAnswer < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :question, :autosave=>true, :counter_cache=>true
  belongs_to :user, :autosave=>true
  accepts_nested_attributes_for :question, :allow_destroy => true  
end
