FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:username) { |n| "username#{n}" }
    password { 'password' }

    # Ensure confirmation is still after creation but before now
    created_at { 1.day.ago }
    confirmed_at { 1.hour.ago }
  end
end
