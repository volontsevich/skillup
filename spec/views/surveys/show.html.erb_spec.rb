require 'rails_helper'
require 'spec_helper'

describe 'surveys/show.html.erb' do

  it 'displays product details correctly' do
    survey = create(:survey_with_question)
    render

    rendered.should have_selector("ol div.row div.col-md-5 li", content: "Who are you?")

  end
end
