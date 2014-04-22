require 'spec_helper'

describe 'Welcome page', js: true do
  let!(:bag_sport) { create :bestseller_with_bag_sport }
  let!(:bag_on_wheels) { create :bestseller_with_bag_on_wheels }

  before :each do
    # create :bestseller
  end

  # context 'Dashboard' do
    # before do
      # sign_in_as user
    # end

    it 'openes correctly' do
      visit root_path

      page.should have_content 'Оригинальные брендовые сумки из США'
      screenshot_and_open_image
    end
  # end
end
