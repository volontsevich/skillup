FactoryGirl.define do
  factory :user do
    email { Faker::Internet.free_email('Nancy') }
    password 'password123'
  end
end
