FactoryBot.define do
  factory :day do
    date_reg { "2019-12-07" }
    month { 12 }
    week { 49 }
    seconds { 0 }
    odd { false }
    user

    trait :wihout_date_reg do
      date_reg { nil }
    end
  end
end
