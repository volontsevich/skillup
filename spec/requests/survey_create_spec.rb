require 'rails_helper'
require 'spec_helper'

describe 'Creates survey and respond', :type => :feature do
  before {
    @user=create_user_and_login
    @answers=%w(Answer1 Answer2 Answer3 Answer4)
  }
  it 'create survey via Factory' do
    survey=create :survey_with_question, user_id: @user.id
    visit survey_path(survey)
    expect(page).to have_content survey.name
    expect(page).to have_content 'Great question1'
  end

  it 'create survey via user', :js => true do
    page.driver.browser.manage.window.maximize
    visit surveys_index_path
    click_link 'New'
    fill_in 'survey_name', with: 'New survey'
    types={'radio' => '1', 'check_box' => '2', 'text' => '3', 'slider' => '4'}
    make_question_with_answers('New Question1', 1, 2, types['radio'])
    make_question_with_answers('New Question2', 2, 2, types['check_box'])
    make_question_with_answers('New Question3', 3, 0, types['text'])
    create_question_slider('New Question4', 4, 1, 3, 2)
    find('input[name="commit"]').click

    expect(page).to have_css('div.col-md-5', text: 'New Question4 Min value 1 Max value 3 By default 2')
    expect(page).to have_css('div.col-md-5', text: 'New Question3')
    expect(page).to have_css('div.col-md-5', text: 'New Question2 Answer2 Answer3')
    expect(page).to have_css('div.col-md-5', text: 'New Question1 Answer2 Answer3')

    expect(page).to have_content 'By default 2'
  end

  it 'edit survey via user', :js => true do
    page.driver.browser.manage.window.maximize
    survey=create :survey_with_question, user_id: @user.id
    visit survey_path(survey)
    click_link 'Edit'
    find('#remove_question_0').click
    find('#remove_answer_1_2').click
    find('#remove_question_2').click
    fill_in 'sqa_3_a_2', with: 10
    add_question('sqa_4', 'Zero')
    find('input[name="commit"]').click
    expect(page).not_to have_css('div.col-md-5', text: 'Great question1')
    expect(page).not_to have_css('div.col-md-5', text: 'Great question3')
    expect(page).to have_css('div.col-md-5', text: 'Great question2 Answer1 Answer2 Answer4')
    expect(page).to have_css('div.col-md-5', text: 'Great question4 Min value 0 Max value 100 By default 10')
    expect(page).to have_css('div.col-md-5', text: 'Zero')
  end

  it 'create respond via user', :js => true do
    survey=create :survey_with_question, user_id: @user.id
    visit survey_path(survey)
    click_link 'Answer'
    find('input[name="respond[questions][1][reply][1][content]"]', visible: false).click
    choose('radio'+'Answer1', visible: false)
    fill_in 'respond[questions][2][reply][0][content]', with: 'Wow'
    first('.ui-slider-handle').drag_by(37, 0) # (37, 0) moves slider to value '40'
    #sleep 10
    find('input[name="commit"]').click
    click_link '1'
    expect(page).to have_css('div.respond', text: 'Answer1 '+@user.email)
    expect(page).to have_css('div.respond', text: 'Answer2 '+@user.email)
    expect(page).to have_css('div.respond', text: 'Wow '+@user.email)
    expect(page).to have_css('div.respond', text: '40 '+@user.email)
  end

  def create_user_and_login
    user=create :user, admin: 1
    visit root_path
    click_button 'Login'
    click_link 'Sign in'
    expect(current_path).to eq(new_user_session_path)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    return user
  end

  def create_question_slider(name, i, a, b, c)
    make_question_with_answers(name, i, 0, 4)
    path='sqa_'+i.to_s
    find_link(path+'_answer_add').click
    fill_in path+'_a_0', with: a
    fill_in path+'_a_1', with: b
    fill_in path+'_a_2', with: c
  end

  def make_question_with_answers(name, i, count, question_type)
    path='sqa_'+i.to_s
    add_question(path, name)
    find('#'+path+'_option').find(:xpath, 'option['+question_type.to_s+']').select_option
    count=0 if question_type==3
    create_answers(path, count)
  end

  def add_question(path, name)
    click_link 'Add Question'
    fill_in path+'_content', with: name
  end

  def create_answers(path, count)
    (1..count).each do |i|
      find_link(path.to_s+'_answer_add').click
      fill_in path.to_s+'_a_'+i.to_s, with: @answers[i]
    end
  end


end