# encoding: utf-8

class BlogsController < ApplicationController
  impressionist :actions=>[:show]
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  
  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.blog')
    @script="board/index"
    @title=t('activerecord.models.blog')+t(:title_separator)+t(:application_name)
    @meta_description=t(:meta_description_blog)        
    
    get_menu('blogs')    
  end

  # GET /blogs
  # GET /blogs.json
  def index
    if @menu_setting.use_category
    
      @blog_categories=BlogCategory.where(:enable=>true)
    
      if(params[:blog_category_id])
        @blog_category_id=params[:blog_category_id].to_i
      else
        if @blog_categories[0]
          @blog_category_id=@blog_categories[0].id.to_i
        else
          @blog_category_id=nil        
        end
      end
    
      @blogs = Blog.where(:blog_category_id=>@blog_category_id).order('id desc').page(params[:page]).per(10)      
    else
      @blogs = Blog.order('id desc').page(params[:page]).per(10) 
    end   
    @template='/blogs/index_default'
    
    respond_to do |format|
      format.html { render @template }
      format.json { render json: @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
   @blog_comments=@blog.blog_comment.order('id desc').page(params[:page]).per(10)
   @blog_comment=BlogComment.new
   
   @title=@blog.title+t(:title_separator)+t(:application_name)
   @script="board/show"
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @blog_comments }
    end  
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @blog.build_blog_content
    
    @script="board/new"
  end

  # GET /blogs/1/edit
  def edit
    @script="board/edit"  
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id=current_user.id
    
    @script="board/new"    

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: @controller_name +t(:message_success_create)}
        format.json { render action: 'show', status: :created, location: @blog }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    @script="board/edit"  
  
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    
    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_params
    params.require(:blog).permit(:blog_category_id, :user_id, :title, :description, :photo, :photo_cache, blog_content_attributes: [:id,:content])
  end
end