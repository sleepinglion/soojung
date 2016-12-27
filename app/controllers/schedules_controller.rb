# encoding: utf-8

class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)
    
    @sub_menu=t(:menu_attendance)
    @controller_name=t('activerecord.models.attendance')
  end  
  
  # GET /attendances
  # GET /attendances.json
  def index
    unless params[:per_page].present?
      params[:per_page]=10
    end
    
    if can? :manage, Attendance
      @attendances = Attendance.order('id desc').page(params[:page]).per(params[:page])
      a_template='attendances/index_admin'
    else
      @attendances = Attendance.where(:user_id=>current_user).order('id desc').all
      @attendance = Attendance.new      
      a_template='attendances/index'
      @script='attendances'
    end
    

    respond_to do |format|
      format.html {render a_template}
      format.json { render json: @attendances }
    end
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
    @attendance = Attendance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attendance }
    end
  end

  # GET /attendances/new
  # GET /attendances/new.json
  def new
    @attendance = Attendance.new
    
    respond_to do |format|
      format.html
      format.json { render json: @attendance }
    end
  end

  # GET /attendances/1/edit
  def edit  
  end

  # POST /attendances
  # POST /attendances.json
  def create
    if can? :manage, Attendance
      @attendance_count=Attendance.count(:conditions => ["DATE(created_at) = ?",Date.today.to_s])
    else
      @attendance_count=Attendance.count(:conditions => ["DATE(created_at) = ? AND user_id=?",Date.today.to_s,current_user.id])

      if @attendance_count.zero?
        @attendance=Attendance.new({:user_id=>current_user.id})
        @attendance.transaction do
          @point_type=PointType.find(4)
          @point=Point.create(:user_id=>current_user.id,:point_type_id=>@point_type.id, :amount=>@point_type.amount)
          
          @user=User.find(current_user.id)
          point=@user.point.to_i+@point_type.amount.to_i
          @user.update(:point=>point)
          
          result=@attendance.save
        end
      else
        result=true
      end
    end

    respond_to do |format|
       if result
        format.html { redirect_to attendances_url, :notice =>  @controller_name +t(:message_success_create)}
        format.json { render json: @attendance, status: :created, location: @attendance }
      else
        format.html { render action: "new" }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /attendances/1
  # PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update_attributes(attendance_params)
        format.html { redirect_to @attendance, :notice =>  @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    
    respond_to do |format|
      format.html { redirect_to attendances_url }
      format.json { head :no_content }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def attendance_params
    params.permit(:id,:user_id)
  end
end