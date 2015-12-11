FactoryGirl.define do


  factory :survey do
    name { Faker::Name.name }
    exp_date  Date.current
    factory :survey_with_question do
      after(:create) do |survey|
        create(:question, content: 'Great question1', survey_id: survey.id, option: 1)
        create(:question, content: 'Great question2', survey_id: survey.id, option: 2)
        create(:question, content: 'Great question3', survey_id: survey.id, option: 3)
        create(:question, content: 'Great question4', survey_id: survey.id, option: 4, meta: '{
"0":{"content":"0"},
"1":{"content":"100"},
"2":{"content":"0"}}')
      end
    end
  end

  factory :question do
    meta '{
"1":{"content":"Answer1"},
"2":{"content":"Answer2"},
"3":{"content":"Answer3"},
"4":{"content":"Answer4"}}'
  end

end