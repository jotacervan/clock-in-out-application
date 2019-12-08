class DashboardController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def index
    week = DateTime.now.strftime('%U')
    odd_days = current_user.days.where(odd: true).count
    week_days = current_user.days.where(week: week)
    total_seconds = week_days.reduce{|total, ops| (total.seconds || total) + ops.seconds }
    worked_hours = format_duration(total_seconds)
    week_seconds = current_user.hours_per_week * 3600
    diff = calc_diff(total_seconds, week_seconds)
    week_balance = format_duration(diff)
    
    render json: { odd_days: odd_days, week_balance: week_balance } , status: :ok
  end

  protected
    def format_duration(total_seconds)
      seconds = total_seconds % 60
      minutes = (total_seconds / 60) % 60
      hours = total_seconds / (60 * 60)

      format("%02d:%02d:%02d", hours, minutes, seconds)
    end
    
    def calc_diff(total, target)
      total - target
    end
end
