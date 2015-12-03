FactoryGirl.define do
  factory :respond do
    question_id {Faker::IDNumber}
    content {Faker::University}
  end

end
