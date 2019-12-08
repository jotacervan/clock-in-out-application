class Day < ApplicationRecord
  belongs_to :user
  has_many :time_regs, dependent: :destroy

  validates :date_reg, presence: true
end
