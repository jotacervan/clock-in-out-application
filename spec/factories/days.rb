FactoryBot.define do
  factory :day do
    date_reg { "2019-12-07" }
    month { 12 }
    week { 49 }
    seconds { 0 }
    odd { false }
    user

    trait :without_date_reg do
      date_reg { nil }
    end

    trait :without_month do
      month { nil }
    end

    trait :without_week do
      week { nil }
    end
  end
end
