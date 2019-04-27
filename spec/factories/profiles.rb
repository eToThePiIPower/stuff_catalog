FactoryBot.define do
  factory :profile do
    homepage { 'https://exacmple.com/' }
    location { 'MyCity, MyState' }
    bio { 'Hello world from my bio!' }

    user
  end
end
