# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
SurveyMail.delete_all
Survey.delete_all
Question.delete_all
User.delete_all
User.create(id: 1, email: 'viktor@mail.ru', password: '11111111', admin: 1)
User.create(id: 2, email: 'serge@mail.ru', password: '11111111', admin: 0)
Survey.create(id: 1, name: 'First survey', user_id: 1)
Question.create(id: 1, survey_id: 1, option: 1, content: 'Question one', meta: '{
"1":{"content":"Answer1"},
"2":{"content":"Answer2"},
"3":{"content":"Answer3"}}')
Question.create(id: 2, survey_id: 1, option: 2, content: 'Question two', meta: '{
"1":{"content":"Answer4"},
"2":{"content":"Answer5"},
"3":{"content":"Answer6"}}')
Question.create(id: 3, survey_id: 1, option: 3, content: 'Question three', meta: '')
Question.create(id: 4, survey_id: 1, option: 4, content: 'Question four', meta: '{
"0":{"content":"1"},
"1":{"content":"100"},
"2":{"content":"50"}}')

SurveyMail.create(survey_id: 1, address: 'email 1')

Survey.create(id: 2, name: 'Second survey', user_id: 1)
Question.create(id: 5, survey_id: 2, option: 1, content: 'Question two', meta: '{
"1":{"content":"Answer4"},
"2":{"content":"Answer5"},
"3":{"content":"Answer6"}}')
SurveyMail.create(survey_id: 2, address: 'email 2')