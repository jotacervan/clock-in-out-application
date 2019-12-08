class TimeReg < ApplicationRecord
  belongs_to :day

  validates :time_reg, presence: true

  after_commit :update_day

  def update_day
    return if self.day.destroyed?
    if destroyed?
      day = Day.find(self.day_id)
    else
      day = self.day
    end
    if day.time_regs.count > 1
      arr = day.time_regs.order(:time_reg).map(&:time_reg)
      if arr.count.even?
        sec = get_seconds(arr)
        day.update(odd: false, seconds: sec )
      elsif destroyed?
        arr.pop
        sec = get_seconds(arr)
        day.update(odd: true, seconds: sec )
      else
        day.update(odd: true )
      end
    else
      day.update(odd: true, seconds: 0)
    end
  end

  def get_seconds(arr)
    sec = 0
    arr.each_slice(2).each do |a|
      sec += a[1]-a[0]
    end
    sec
  end
end
