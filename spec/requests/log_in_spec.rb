require 'rails_helper'
require 'spec_helper'
require 'devise'

describe 'LogInSpec', :type => :feature do

  it 'user' do

    user=create :user, admin: 0
    visit root_path
    click_button "Login"
    click_link "Sign in"
    expect(current_path).to eq(new_user_session_path)
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(current_path).to eq(root_path)
    click_button user.email
    expect(page).to have_content('My surveys')

  end
  it 'admin' do

    user=create :user, admin: 1
    visit root_path
    click_button "Login"
    click_link "Sign in"
    expect(current_path).to eq(new_user_session_path)
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(current_path).to eq(root_path)
    click_button user.email
    expect(page).to have_content('User management')

  end


end