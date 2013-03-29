require 'spec_helper'

feature 'Welcome page // Root rage' do
  background do
    visit home_page
  end

  scenario 'visit index page', :js => true do
    page.should have_content 'The Perfect Perfume For Valentines Day'
  end
end