# encoding: utf-8

class GalleriesController < BoardController
  impressionist :actions=>[:show]
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  
  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.gallery')
    @script="galleries"
    @title=t('activerecord.models.gallery')+t(:title_separator)+t(:application_name)    
    @meta_description=t(:meta_description_gallery)
    
    @page_itemtype="http://schema.org/ImageGallery"
    
    get_menu('galleries')
  end
  
  # GET /galleries
  # GET /galleries.json
  def index
    if @menu_setting.use_category         
      @gallery_categories=GalleryCategory.all
    
      if(params[:gallery_category_id])
        @gallery_category_id=params[:gallery_category_id].to_i
      else
        if @gallery_categories[0]
          @gallery_category_id=@gallery_categories[0].id.to_i
        else
          @gallery_category_id=nil        
        end
      end
    
      @galleries = Gallery.where(:gallery_category_id=>@gallery_category_id).order('id desc').page(params[:page]).per(60)    
    else 
      @galleries = Gallery.order('id desc').page(params[:page]).per(60)
    end
    
    if(params[:id])
      @gallery = Gallery.find(params[:id])
    else
      @gallery=@galleries[0]
    end
    
    if @gallery
      @title=@gallery.title+'-'+t(:application_name)    
      @meta_description=@gallery.content
    end
      
            
    @script='galleries'    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @galleries }
    end
  end
  
  # GET /galleries/1
  # GET /galleries/1.json
  def show
    if @menu_setting.use_category
      @gallery_categories=GalleryCategory.all
      @gallery_category_id=@gallery.gallery_category_id
      @galleries = Gallery.where(:gallery_category_id=>@gallery_category_id).order('id desc').page(params[:page]).per(60)    
    else 
      @galleries = Gallery.order('id desc').page(params[:page]).per(60)
    end
    
    if @gallery
      @title=@gallery.title+'-'+t(:application_name)
      @meta_description=@gallery.content
    end
    
    @script='galleries'  
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @gallery }
    end
  end
  
  # GET /galleries/new
  # GET /galleries/new.json
  def new
    @gallery = Gallery.new
    @gallery_categories=GalleryCategory.all
    @gallery_category_id=params[:gallery_category_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @gallery }
    end
  end
  
  # GET /galleries/1/edit
  def edit
    @gallery_categories=GalleryCategory.all
    @gallery_category_id=@gallery.gallery_category.id    
  end
  
  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.user_id=current_user.id    
    
    respond_to do |format|
      if @gallery.save
        format.html { redirect_to gallery_url(@gallery), :notice=> @controller_name +t(:message_success_create)}
        format.json { render :json => @gallery, :status => :created, :location => @gallery }
      else
        format.html { render :action => "new" }
        format.json { render :json => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /galleries/1
  # PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update_attributes(gallery_params)    
        format.html { redirect_to gallery_url(@gallery), :notice=> @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    
    respond_to do |format|
      format.html { redirect_to galleries_url(:gallery_category_id=>@gallery.gallery_category_id) }
      format.json { head :ok }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gallery_params
    params.require(:gallery).permit(:id,:user_id,:gallery_category_id,:title,:photo,:photo_cache,:content)
  end  
end
