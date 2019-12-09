class Day < ApplicationRecord
  belongs_to :user
  has_many :time_regs, -> { order(time_reg: :asc) }, dependent: :destroy

  validates :date_reg, :month, :week, presence: true

  def hours
    Time.at(self.seconds).utc.strftime('%H:%M:%S')
  end

  def month_name
    Date::MONTHNAMES[self.month]
  end

  def status
    if self.odd
      'Missing Entry'
    else
      if self.time_regs.count > 0
        'OK'
      else
        'Empty'
      end
    end
  end
end
