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
Survey.create(id: 1, name: 'First survey', user_id: 1, start_date: '2015-12-10', send_date: '2015-12-11', exp_date: '2015-12-15',)
Question.create(id: 1, survey_id: 1, option: 1, content: 'What is your gender?', meta: '{
"1":{"content":"Male"},
"2":{"content":"Female"},
"3":{"content":"Don`t know"}}')
Question.create(id: 2, survey_id: 1, option: 2, content: 'What do you like? ', meta: '{
"1":{"content":"Beer"},
"2":{"content":"Whiskey"},
"3":{"content":"Water"}}')
Question.create(id: 3, survey_id: 1, option: 3, content: 'What is your name?', meta: '')
Question.create(id: 4, survey_id: 1, option: 4, content: 'How old are you?', meta: '{
"0":{"content":"18"},
"1":{"content":"90"},
"2":{"content":"20"}}')

SurveyMail.create(survey_id: 1, address: 'v.volontsevich@mobidev.biz', sent: false)
SurveyMail.create(survey_id: 1, address: 'viktor_promo@mail.ru', sent: false)

Survey.create(id: 2, name: 'Second survey', user_id: 1, start_date: '2015-12-09', send_date: '2015-12-10', exp_date: '2015-12-15',)
Question.create(id: 5, survey_id: 2, option: 1, content: 'Will you go to the race?', meta: '{
"1":{"content":"Yes"},
"2":{"content":"No"},
"3":{"content":"Maybe"}}')
SurveyMail.create(survey_id: 2, address: 'v.volontsevich@mobidev.biz',sent: false)