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
      page.should have_content product_1.title
      page.should_not have_content product_4.title
    end

    within('#new_products') do
      page.all(".new_product").count.should eql(6)
    end
  end

  it 'way to pay order ( checking )' do
    page.find('#rating_point_6').click
    click_on('Отправить')

    within('.progress_table') do
      page.should have_content('(100.0)')
    end

    within('.count_of_vote') do
      page.should have_content('1')
    end
  end
end
