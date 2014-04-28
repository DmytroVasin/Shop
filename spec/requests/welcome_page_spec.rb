require 'spec_helper'

describe 'Welcome page', js: true do
  let!(:product_1) { create :product_bestseller_with_bag_sport }
  let!(:product_2) { create :product_bestseller_with_bag_on_wheels }
  let!(:product_3) { create :product_bestseller_with_zebra_wallet_kate }
  let!(:product_4) { create :product_with_laptop_vivienne }
  let!(:product_5) { create :product_with_laptop_slim }
  let!(:product_6) { create :product_with_wallet_bleecker }

  before :each do
    visit root_path
  end

  it 'openes correctly' do
    page.should have_content 'Оригинальные брендовые сумки из США'
    page.should have_content 'Все товары'
    page.should have_content 'Акции/Новости'
    page.should have_content 'Пн-Пт: с 10:00 до 18:00'
    page.should have_content 'Суб: с 10:00 до 15:00'
  end

  it 'show bestseller/newest in new fields' do
    within('#slider') do
      page.all("li").count.should eql(6)
    end

    within('#new_products') do
      page.all('.new_product').count.should eql(3)
    end
  end

  it 'pay for an order chooser' do
    page.find('#rating_point_6').click
    click_on('Отправить')

    within('.progress_table') do
      page.should have_content('(100.0)')
    end

    within('.count_of_vote') do
      page.should have_content('1')
    end
  end

  it 'counts of banners' do
    within('#remote_site') do
      page.all("img").count.should eql(4)
    end
  end
end
