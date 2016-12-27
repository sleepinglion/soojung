# encoding: utf-8
require 'atom'

class NaverController < ApplicationController

  def initialize(*params)
  end
  
  # GET /naver  
  def index
    @resources = Resource.where(:enable=>true).order([:priority,:id])    
    @home = @resources[0]
    @home_update=@home.last_updated
    case params[:type]      
      when 'site'   
        @response = Atom::Entry.new do |f|
          f.id = 'tag:'+t(:domain)+',2010:site'  
          f.title = t(:application_name)
          f.links << Atom::Link.new(:rel=>'self',:href => 'http://'+t(:domain)+'/naver?id=tag:'+t(:domain)+',2010:site&amp;type=site')          
          f.links << Atom::Link.new(:rel=>'alternative',:href => 'http://'+t(:domain))
          f.updated = @home_update
        end
        render xml: @response.to_xml
      when 'channel'
        if params[:channel]
        @resource = Resource.where(:controller=>params['channel']).first
        @response = Atom::Entry.new do |f|
          f.id = 'tag:'+t(:domain)+',2010:channel:'+@resource.controller 
          f.title = t(:application_name)
          f.links << Atom::Link.new(:rel=>'self',:href => 'http://'+t(:domain)+'/naver?id=tag:'+t(:domain)+',2010:channel:'+@resource.controller+'&amp;type=channel')          
          f.links << Atom::Link.new(:rel=>'alternative',:href => 'http://'+t(:domain)+'/'+@resource.controller)
          f.updated = @resource.last_updated
        end
        render xml: @response.to_xml
        else 
          @response = Atom::Feed.new do |f|
          f.id = 'tag:'+t(:domain)+',2010:site'
          f.title = t(:application_name)
          f.links << Atom::Link.new(:rel=>'self',:href => 'http://'+t(:domain)+'/naver?id=tag:'+t(:domain)+',2010:site&amp;type=site')          
          f.links << Atom::Link.new(:rel=>'alternative',:href => 'http://'+t(:domain))
          f.updated = @home_update
          @resources.each do |r|
            f.entries << Atom::Entry.new do |e|
              e.id = 'tag:'+t(:domain)+',2010:channel:'+r.controller
              e.title = r.controller
              e.links << Atom::Link.new(:rel=>'self',:href => 'http://'+t(:domain)+'/naver?id=tag:'+t(:domain)+',2010:channel:'+r.controller+'&amp;type=channel')          
              e.links << Atom::Link.new(:rel=>'alternative',:href => 'http://'+t(:domain)+'/'+r.controller)
              e.updated = r.updated_at
            end
          end
         end
          render xml: @response.to_xml
        end
      when 'article'
        if params[:channel]
          
          case params[:channel]
            when 'notices'
              @resources = Notice.order('id desc').page(params[:page]).per(10)
              controller='notices'        
            when 'blogs'
              @resources = Blog.order('id desc').page(params[:page]).per(10)
              controller='blogs'
            when 'galleries'
              @resources = Gallery.order('id desc').page(params[:page]).per(10)
              controller='galleries'
            when 'guest_books'
              @resources = GuestBook.order('id desc').page(params[:page]).per(10)
              controller='guest_books' 
          end
            
          @response = Atom::Feed.new do |f|
          f.id = 'tag:'+t(:domain)+',2010:site'
          f.title = t(:application_name)
          f.links << Atom::Link.new(:rel=>'self',:href => 'http://'+t(:domain)+'/naver?id=tag:'+t(:domain)+',2010:site&amp;type=site')          
          f.links << Atom::Link.new(:rel=>'alternative',:href => 'http://'+t(:domain))
          f.updated = @home_update

          @resources.each do |r|
            f.entries << Atom::Entry.new do |e|
              e.id = 'tag:'+t(:domain)+',2010:channel:'+controller
              e.title = r.title
              e.content= r.content
              e.links << Atom::Link.new(:rel=>'alternative',:href => 'http://'+t(:domain)+'/'+controller+'/'+r.id.to_s)
              e.links << Atom::Link.new(:rel=>'channel',:href => 'http://'+t(:domain)+'/naver?id=tag:'+t(:domain)+',2010:channel:'+controller+'&amp;type=channel')
              e.links << Atom::Link.new(:rel=>'channel-alternative',:href => 'http://'+t(:domain)+'/naver?id=tag:'+t(:domain)+',2010:channel:'+controller+'&amp;type=channel')
              e.published = r.created_at                     
              e.updated = r.updated_at
            end
          end
         end
          render xml: @response.to_xml
        else
          @response = Atom::Feed.new do |f|
          f.id = 'tag:'+t(:domain)+',2010:site'
          f.title = t(:application_name)
          f.links << Atom::Link.new(:rel=>'self',:href => 'http://'+t(:domain)+'/naver?id=tag:'+t(:domain)+',2010:site&amp;type=site')          
          f.links << Atom::Link.new(:rel=>'alternative',:href => 'http://'+t(:domain))
          f.updated = @home_update
          @resources = Resource.where(:enable=>true).order([:priority,:id])
          @resources.each do |r|
            f.entries << Atom::Entry.new do |e|
              e.id = 'tag:'+t(:domain)+',2010:channel:'+r.controller
              e.title = r.controller
              e.links << Atom::Link.new(:rel=>'self',:href => 'http://'+t(:domain)+'/naver?id=tag:'+t(:domain)+',2010:channel:'+r.controller+'&amp;type=channel')          
              e.links << Atom::Link.new(:rel=>'alternative',:href => 'http://'+t(:domain)+'/'+r.controller)
              e.updated = Time.parse('2003-12-13T18:30:02Z')
            end
          end
         end
          render xml: @response.to_xml
        end
      when 'deleted'
    end
  end
  
  def status 
    require 'net/http'

    url = URI.parse('http://syndication.openapi.naver.com/status/?site=www.soojung.pe.kr')
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
        }
    @response=res.body    
    
  end
end