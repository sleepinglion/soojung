# encoding: utf-8

class AboutController < ApplicationController
  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.about')
    @meta_description=t(:meta_description_about)
    
    @page_itemtype="http://schema.org/AboutPage"
    
    get_menu('site')
  end

  def index
    
  end
end
