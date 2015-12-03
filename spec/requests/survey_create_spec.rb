require 'rails_helper'
require 'spec_helper'

describe 'New Survey', :type => :feature do
  before { @user=create_and_login_as_admin }

  def create_and_login_as_admin
    user=create :user, admin: 1
    visit root_path
    click_button "Login"
    click_link "Sign in"
    expect(current_path).to eq(new_user_session_path)
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    # expect(current_path).to eq(root_path)
    return user
  end


  it 'create via Factory and show' do
    survey=create :survey_with_question, user_id: @user.id
    visit survey_path(survey)
    expect(page).to have_content survey.name
    expect(page).to have_content 'Great question?'
  end

  it 'create via user and show', :js => true do
    visit surveys_index_path
    # page.driver.browser.manage.window.maximize
    click_link 'New'
    fill_in 'survey_name', with: 'New survey'
    click_link 'Add Question'
    fill_in 'sqa_1_content', with: 'New question1'
    find('#sqa_1_option').find(:xpath, 'option[1]').select_option
    find_link('sqa_1_answer_add').click
    fill_in 'sq1_a_1', with: 'New Answer1'
    find_link('sqa_1_answer_add').click
    fill_in 'sq1_a_2', with: 'New Answer2'

    click_link 'Add Question'
    fill_in 'sqa_2_content', with: 'New question2'
    find('#sqa_2_option').find(:xpath, 'option[2]').select_option
    find_link('sqa_2_answer_add').click
    fill_in 'sq2_a_1', with: 'New Answer3'
    find_link('sqa_2_answer_add').click
    fill_in 'sq2_a_2', with: 'New Answer4'

    click_link 'Add Question'
    fill_in 'sqa_3_content', with: 'New question3'
    find('#sqa_3_option').find(:xpath, 'option[3]').select_option
    page.execute_script('window.scrollTo(0,100000)')
    click_link 'Add Question'
    fill_in 'sqa_4_content', with: 'New question4'
    find('#sqa_4_option').find(:xpath, 'option[4]').select_option
    find_link('sqa_4_answer_add').click
    fill_in 'sq4_a_0', with: '5'
    fill_in 'sq4_a_1', with: '8'
    fill_in 'sq4_a_2', with: '7'
    page.execute_script('window.scrollTo(0,100000)')
    # find_link('sq1_a_1_remove').click
    find('input[name="commit"]').click
    expect(page).to have_content 'By default 7'
  end


end