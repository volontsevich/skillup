require 'rails_helper'
require 'spec_helper'
RSpec.describe Admin::UsersController, type: :controller do
  login_user

  it 'should have a current_user' do
    expect(subject.current_user).not_to be_nil
  end

end
