require 'spec_helper'

describe 'Welcome page', js: true do
  let!(:product_1) { create :bestseller_with_bag_sport }
  let!(:product_2) { create :bestseller_with_bag_on_wheels }
  let!(:product_3) { create :bestseller_with_zebra_wallet_kate }
  let!(:product_4) { create :bestseller_with_wallet_bleecker }
  let!(:product_5) { create :bestseller_with_laptop_vivienne }
  let!(:product_6) { create :bestseller_with_laptop_slim }

  before :each do
    visit root_path
  end

  it 'openes correctly' do
    page.should have_content 'Оригинальные брендовые сумки из США'
    page.should have_content 'Все товары'
    page.should have_content 'Акции/Новости'
  end

  it 'show bestseller/newest in new fields' do
    within('#slider') do
      page.all("li").count.should eql(3)
    end

    within('#new_products') do
      page.all(".new_product").count.should eql(6)
      page.should have_content product_1.title.truncate(20)
      page.should_not have_content product_4.title.truncate(20)
    end
  end
end
