FactoryBot.define do
  factory :time_reg do
    time_reg { "2019-12-07 09:00:00" }
    day

    trait :wihout_time_reg do
      time_reg { nil }
    end
    trait :lunch_time do
      time_reg{ "2019-12-07 12:00:00" }
    end
    trait :end_lunch_time do
      time_reg{ "2019-12-07 13:00:00" }
    end
    trait :end_day do
      time_reg { "2019-12-07 18:00:00" }
    end
  end
end
