require 'rails_helper'
require 'spec_helper'
require 'devise'

describe 'User test', :type => :feature do

  it 'check user panel' do
    login_and_push_menu_link(false)
    expect(page).to have_content('My surveys')
  end

  it 'check admin panel' do
    login_and_push_menu_link(true)
    expect(page).to have_content('User management')
  end

  it 'create new admin from admin menu', :js => true do
    login_and_push_menu_link(true)
    click_link 'User management'
    click_link 'New'
    fill_in 'Email', with: 'bugaga@gmail.com'
    fill_in 'Password', with: 'bugaga@gmail.com'
    fill_in 'Password confirmation', with: 'bugaga@gmail.com'
    check 'user_admin'
    find('input[name="commit"]').click
    expect(page).to have_content('bugaga@gmail.com')
  end

  def login_and_push_menu_link(is_admin)
    user=create :user, admin: is_admin
    log_in(user)
    click_button user.email.truncate(20)
  end

  def log_in(user)
    visit root_path
    click_button 'Login'
    click_link 'Sign in'
    expect(current_path).to eq(new_user_session_path)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(current_path).to eq(root_path)
  end

end