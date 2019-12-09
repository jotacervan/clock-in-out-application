class TimeRegController < ApplicationController
  respond_to :json
  before_action :authenticate_user!, except: [:add_entry, :register_entry]
  before_action :get_time_reg, only: [:show, :update, :destroy]
  
  def add_entry
  end

  def register_entry
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      time_reg = create_time_reg(nil, user)
      render json: {}, status: :ok
    else
      render json: { message: 'Usuário ou senha inválidos' }, status: 402
    end
  end

  def index
    @time_regs = TimeReg.where(day_id: params[:day_id])
    render json: @time_regs, status: :ok
  end

  def show
    render json: @time_reg, status: :ok
  end

  def create
    time_reg = create_time_reg(time_reg_params[:time_reg], current_user)
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

  protected
    def create_time_reg(time, user)
      if time
        dateTime = DateTime.parse time
      else
        dateTime = DateTime.now
      end
      day = user.days.find_by(date_reg: dateTime)
      day = user.days.create(date_reg: dateTime, month: dateTime.strftime('%m'), week:  dateTime.strftime('%U')) unless day.present?
      time_reg = day.time_regs.create(time_reg: dateTime)
      time_reg
    end

  private
    def get_time_reg
      @time_reg = TimeReg.find(params[:id])
    end

    def time_reg_params
      params.permit(:time_reg)
    end
end
