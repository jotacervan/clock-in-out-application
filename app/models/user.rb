class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, supervisor: 1, user: 2 }

  validates :name, :email, presence: true
end
