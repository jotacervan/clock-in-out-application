class DayController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def index
    days = current_user.days.order(date_reg: :desc)
    render json: days.to_json(methods: [:hours, :status, :month_name]), status: :ok
  end

  def show
    day = Day.find(params[:id])
    render json: day.to_json(
      methods: [:hours, :status], 
      include: { time_regs: { methods: [:time] } }
    ), status: :ok
  end
end
