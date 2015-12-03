FactoryGirl.define do

  factory :survey do
    name { Faker::Name.name }

    factory :survey_with_question do
      after(:create) do |survey|
        create(:question, survey_id: survey.id)
      end
    end
  end

  factory :question do
    content 'Great question?'
    option  1
    meta '{"1":{"content":"Yes"},"2":{"content":"No"}}'
  end

end