require 'spec_helper'

describe 'Product show page', js: true do
  let!(:product_1) { create :bestseller_with_bag_on_wheels }
  let!(:product_2) { create :bestseller_with_zebra_wallet_kate }

  before :each do
    visit root_path
  end

  it 'on dashboard product is displayed correctly' do
    within('.new_product') do
      page.should have_content product_1.title
      page.should have_content 'цена'
      page.should have_content product_1.price
    end
  end

  it 'link on dashboard redirect to correct product' do
    within('.new_product') do
      click_on('Просмотр')
    end
    current_path.should == product_path(product_1)
  end

  it 'all data are on the page' do
    visit product_path(product_1)

    page.should have_content product_1.title
    page.should have_content product_1.price
    page.should have_content product_1.old_price
    page.should have_content 'Показать Видео'
    page.should have_css('.adding_to_cart')
    page.should have_content 'Цвет'
    page.should have_content 'На главную'

    click_on('На главную')
    current_path.should == root_path
  end

  it 'should display/hide next img arrow' do
    visit product_path(product_1)
    page.should have_css('.next_img')

    visit product_path(product_2)
    page.should_not have_css('.next_img')
  end
end
