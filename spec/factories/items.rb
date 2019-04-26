FactoryBot.define do
  factory :item do
    isbn { '978-1-68050-250-3' }
    title { 'Rails 5 Test Prescriptions' }
    value { 39.95 }
    user
  end
end
