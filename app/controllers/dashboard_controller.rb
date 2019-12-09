class DashboardController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def index
    week = DateTime.now.strftime('%U')
    odd_days = current_user.days.where(odd: true)
    week_days = current_user.days.where(week: week)
    total_seconds = week_days.reduce(0){|total, ops| (total.seconds || total) + ops.seconds }
    worked_hours = format_duration(total_seconds || 0)
    week_seconds = current_user.hours_per_week * 3600
    diff = calc_diff(total_seconds || 0, week_seconds)
    week_balance = format_duration(diff)
    
    render json: { odd_days: odd_days, week_balance: worked_hours } , status: :ok
  end

  protected
    def format_duration(total_seconds)
      minutes = (total_seconds / 60) % 60
      hours = total_seconds / (60 * 60)

      format("%02d:%02d", hours, minutes)
    end
    
    def calc_diff(total, target)
      total - target
    end
end
