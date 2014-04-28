require 'spec_helper'

describe 'Product show page', js: true do
  let!(:product_1) { create :product_bestseller_with_bag_on_wheels, title: 'Title of main product' }
  let!(:product_2) { create :product_with_laptop_vivienne }
  let!(:product_see_also_not_included) { create :product_with_wallet_bleecker, title: 'Not the same' }

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

  it 'displayes features for product' do
    visit product_path(product_1)

    within('#categories_of_product') do
      page.should have_content 'Материал'
      page.should have_content 'Кожа'
      page.should have_content 'Тип закрытия'
      page.should have_content 'Молния'
      page.should have_content 'Особенности'
      page.should have_content 'Карман для ноут-а'
    end
  end

  it 'displayes three more product in the also viewed' do
    FactoryGirl.create(:product_with_laptop_slim, title: 'Same product 1', categories: [Category.first])
    FactoryGirl.create(:product_with_laptop_slim, title: 'Same product 2', categories: [Category.first])
    FactoryGirl.create(:product_with_laptop_slim, title: 'Same product 3', categories: [Category.first])

    visit product_path(product_1)

    within('.also_like_field') do
      page.should_not have_content('Title of main product')
      page.all('.new_product').count.should eql(3)
      page.should have_content('Same product 1')
      page.should have_content('Same product 2')
      page.should have_content('Same product 3')
    end
  end

  it 'displayes only same category in the also viewed' do
    product_see_also_1 = FactoryGirl.create(:product_with_laptop_slim, title: 'Current title is same', categories: [Category.first])

    visit product_path(product_1)

    within('.also_like_field') do
      page.should_not have_content(product_see_also_not_included.title)
      page.should_not have_content(product_1.title)
      page.should have_content(product_see_also_1.title)
    end
  end
end
