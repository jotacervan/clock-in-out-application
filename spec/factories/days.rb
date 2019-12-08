FactoryBot.define do
  factory :day do
    date_reg { "2019-12-07" }
    month { 1 }
    week { 1 }
    seconds { 3600 }
    odd { false }
    user

    trait :wihout_date_reg do
      date_reg { nil }
    end
  end
end
