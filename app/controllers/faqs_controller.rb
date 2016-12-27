# encoding: utf-8

class FaqsController < BoardController
  before_action :authenticate_user!, :except => [:index,:show]  
  before_action :set_faq, only: [:show, :edit, :update, :destroy]  
  
  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.faq')
    @script="faqs"
    @title=t('activerecord.models.faq')+t(:title_separator)+t(:application_name)    
    @meta_description=t(:meta_description_faq)
    @page_itemtype="http://schema.org/QAPage"    
    
    get_menu('faqs')
  end
  
  # GET /faqs
  # GET /faqs.json
  def index
    @faq_categories = FaqCategory.all
    
    if(params[:faq_category_id])
      @categoryId=params[:faq_category_id].to_i
    else
      if @faq_categories[0]
        @categoryId=@faq_categories[0].id.to_i
      else
        @categoryId=nil        
      end
    end
    
    @faqs = Faq.where(:faq_category_id=>@categoryId).order('id desc').page(params[:page]).per(10)
    
    if(params[:id])
      @faq = Faq.find(params[:id])
    end
    
    @script='faqs'
    
    admin=false
    if(current_user)
      if(current_user.admin)
        admin=true
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {:faqs=>@faqs,:admin=>admin} }
    end
  end
  
  # GET /faqs/1
  # GET /faqs/1.json
  def show
    @faqContent=FaqContent.find(params[:id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @faqContent }
    end
  end
  
  # GET /faqs/new
  # GET /faqs/new.json
  def new
    @faq = Faq.new
    @faq.build_faq_content
    @faq_categories = FaqCategory.all
    @faq_category_id=params[:faq_category_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @faq }
    end
  end
  
  # GET /faqs/1/edit
  def edit
    @faq_categories = FaqCategory.all
    @faq_category_id=@faq.faq_category.id
  end
  
  # POST /faqs
  # POST /faqs.json
  def create
    @faq = Faq.new(faq_params)
    
    respond_to do |format|
      if @faq.save
        format.html { redirect_to faqs_url(:faq_category_id=>@faq.faq_category.id), :notice=> @controller_name +t(:message_success_create)}
        format.json { render json: @faq, status: :created, location: @faq }
      else
        format.html { render action: "new" }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /faqs/1
  # PUT /faqs/1.json
  def update
    @faq = Faq.find(params[:id])
    
    respond_to do |format|
      if @faq.update_attributes(faq_params)      
        format.html { redirect_to faqs_url(:faq_category_id=>@faq.faq_category.id), :notice=> @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /faqs/1
  # DELETE /faqs/1.json
  def destroy
    @faq.destroy
    
    respond_to do |format|
      format.html { redirect_to faqs_url(:faq_category_id=>@faq.faq_category.id) }
      format.json { head :ok }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_faq
    @faq = Faq.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def faq_params
    params.require(:faq).permit(:id,:faq_category_id,:title)
  end  
end