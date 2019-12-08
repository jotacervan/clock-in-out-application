class TimeReg < ApplicationRecord
  belongs_to :day

  validates :time_reg, presence: true

  after_create :update_day

  def update_day
    day = self.day
    if day.time_regs.count > 1
      arr = day.time_regs.map(&:time_reg)
      if arr.count.even?
        sec = 0
        arr.each_slice(2).each do |a|
          sec += a[1]-a[0]
        end
        day.update(odd: false, seconds: sec )
      else
        day.update(odd: true )
      end
    else
      day.update(odd: true, seconds: 0)
    end
  end
end
