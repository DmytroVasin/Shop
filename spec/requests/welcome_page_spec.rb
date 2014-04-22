require 'spec_helper'

describe 'Welcome page', js: true do
  # let(:deal_name) { 'DHH' }

  before :each do
    visit home_page
  end

  # context 'Dashboard' do
    # before do
      # sign_in_as user
    # end

    it 'openes correctly' do
      page.should have_content 'Оригинальные брендовые сумки из США'
    end
  # end
end
