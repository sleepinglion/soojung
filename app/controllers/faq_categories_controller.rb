# encoding: utf-8

class FaqCategoriesController < BoardController
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :set_faq_category, only: [:show, :edit, :update, :destroy]
  
  def initialize(*params)
    super(*params)
    
    @controller_name=t('activerecord.models.question')
    @style="board"    
  end
    
  # GET /faq_categories
  # GET /faq_categories.json
  def index
    @faq_categories = FaqCategory.order('id desc').page(params[:page]).per(10)
    @script='board/faqs/index'
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @faq_categories }
    end
  end

  # GET /faq_categories/1
  # GET /faq_categories/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @faq_category }
    end
  end

  # GET /faq_categories/new
  # GET /faq_categories/new.json
  def new
    @faq_category = FaqCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @faq_category }
    end
  end

  # GET /faq_categories/1/edit
  def edit
  end

  # POST /faq_categories
  # POST /faq_categories.json
  def create
    @faq_category = FaqCategory.new(faq_category_params)

    respond_to do |format|
      if @faq_category.save
        format.html { redirect_to faqs_url(:faq_category_id=>@faq_category), :notice=> @controller_name +t(:message_success_create)}
        format.json { render json: @faq_category, status: :created, location: @faq_category }
      else
        format.html { render action: "new" }
        format.json { render json: @faq_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /faq_categories/1
  # PUT /faq_categories/1.json
  def update
    respond_to do |format|
      if @faq_category.update_attributes(faq_category_params)
        format.html { redirect_to faqs_url(:faq_category_id=>@faq_category), :notice=> @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @faq_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faq_categories/1
  # DELETE /faq_categories/1.json
  def destroy
    @faq_category.destroy

    respond_to do |format|
      format.html { redirect_to faqs_url }
      format.json { head :ok }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_faq_category
    @faq_category = FaqCategory.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def faq_category_params
    params.require(:faq_category).permit(:id,:title)
  end  
end
