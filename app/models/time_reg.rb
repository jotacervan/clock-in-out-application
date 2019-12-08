class TimeReg < ApplicationRecord
  belongs_to :day

  validates :time_reg, presence: true
end
