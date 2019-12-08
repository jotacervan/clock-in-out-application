FactoryBot.define do
  factory :time_reg do
    time_reg { "2019-12-07 20:25:43" }
    day

    trait :wihout_time_reg do
      time_reg { nil }
    end
  end
end
