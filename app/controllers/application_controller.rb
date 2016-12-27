# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout  
  before_action :set_locale
  before_action :set_resources
  before_action :set_ad, only: [:index, :show]
  
  def initialize(*params)
    super(*params)
    
    @title=t(:application_name)
    
    @application_name=t(:application_name)
    @controller_name=t(:application_name)
    
    @meta_robot='all, index, follow'
    @meta_description=t(:meta_description)
    @meta_keyword=t(:meta_keyword)
           
    @script='application'
    
    @page_itemtype="http://schema.org/WebPage"  
    
    @menu_setting=nil
  end
  
  def set_resources
    @resources = Resource.where(:enable=>true).where(:menu_display=>true).order([:priority,:id])
  end
  
  def set_locale
     I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def layout
    if params[:no_layout]
      return false
    else
      return 'application'
    end
  end
  
  protected
  
  def set_ad 
    @ad=true
  end
  
  def get_menu(menu)
    @menu_setting=Resource.where(:controller=>menu).first
  end
end
