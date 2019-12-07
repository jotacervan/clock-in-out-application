FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'test@email.com.br' }
    password { '12345678' }
    password_confirmation { '12345678' }

    trait :without_name do
      name { nil }
    end
    trait :without_email do
      email { nil }
    end
    trait :without_password do
      password { nil }
    end
  end
end
