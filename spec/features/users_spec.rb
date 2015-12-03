require 'rails_helper'
require 'spec_helper'
RSpec.describe "Users", type: :feature do

  describe "GET /users/sign_up" do
    it "check page" do
      visit new_user_password_path
      expect(page).to have_content 'Sign up'
    end
  end
  describe "check admin panel" do

    it "sign in" do
      visit new_user_session_path
      fill_in 'Email', with: "viktor@mail.ru"
      fill_in 'Password', with: "11111111"
      click_button 'Log in'
      click_button 'viktor@mail.ru'
      expect(page).to have_content 'User management'
    end
  end

  describe "check user panel" do

    it "sign in" do
      visit new_user_session_path
      fill_in 'Email', with: "serge@mail.ru"
      fill_in 'Password', with: "11111111"
      click_button 'Log in'
      click_button 'serge@mail.ru'
      expect(page).to have_content 'My surveys'
    end
  end


end
