# encoding: utf-8

class FaqContent < ActiveRecord::Base
  validates_presence_of :content   
  belongs_to :faq, :autosave=>true, :foreign_key => :id
  accepts_nested_attributes_for :faq
end
