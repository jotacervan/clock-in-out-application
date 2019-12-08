class TimeRegController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  before_action :get_time_reg, only: [:show, :update, :destroy]
  
  def index
    @time_regs = TimeReg.where(day_id: params[:day_id])
    render json: @time_regs, status: :ok
  end

  def show
    render json: @time_reg, status: :ok
  end

  def create
    if time_reg_params[:time_reg]
      dateTime = DateTime.parse time_reg_params[:time_reg]
    else
      dateTime = DateTime.now
    end
    day = current_user.days.find_by(date_reg: dateTime)
    day = current_user.days.create(date_reg: dateTime, month: dateTime.strftime('%m'), week:  dateTime.strftime('%U')) unless day.present?
    time_reg = day.time_regs.create(time_reg: dateTime)
    
    render json: time_reg,  status: :created
  end

  def update
    @time_reg.update(time_reg_params)
    render json: @time_reg, status: :ok
  end

  def destroy
    @time_reg.destroy
    render json: {}, status: :ok
  end

  private
    def get_time_reg
      @time_reg = TimeReg.find(params[:id])
    end

    def time_reg_params
      params.permit(:time_reg)
    end
end
