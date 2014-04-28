require 'spec_helper'

describe 'Cart', js: true do
  let!(:product_1) { create :product_bestseller_with_bag_sport }

  before :each do
    visit product_path(product_1)
  end

  it 'opened cart page' do
    page.should_not have_content 'Моя Корзина'
    page.find('.adding_to_cart').click()
    page.should have_content 'Моя Корзина'
    page.should have_content 'Название'
    page.should have_content 'Итого'
    page.should have_content 'Обратно к покупкам'
    page.should have_content 'Оформить заказ'
    page.should have_content product_1.title

    cart = Cart.last
    line_item = cart.line_items.first
    line_item.product_id.should eq product_1.id
    line_item.quantity.should   eq 1
  end

  context 'in the Cart' do
    before :each do
      page.find('.adding_to_cart').click()
    end

    it 'redirect to product page on click on title of product' do
      click_on(product_1.title)
      current_path.should == product_path(product_1)
    end

    it 'destoy cart & redirect to products page' do
      page.find('.empty_cart').click()
      page.should have_content 'Ваша корзина пуста'
      current_path.should == products_path
    end

    it 'should increase value in cart' do
      page.find('.quantity div').text.should eq '1'
      Cart.last.line_items.first.quantity.should eq 1
      page.find('#cart_total_price p').text.should eq 'Итого: 140.80 грн.'

      within('.actions_with_quantity') do
        page.find('.increase img').click()
      end
      sleep 1

      page.find('.quantity div').text.should eq '2'
      Cart.last.line_items.first.quantity.should eq 2

      page.find('#cart_total_price p').text.should eq 'Итого: 281.60 грн.'
    end

    it 'should decrease and remove cart after removing last item' do
      page.find('.quantity div').text.should eq '1'
      Cart.last.line_items.first.quantity.should eq 1

      within('.actions_with_quantity') do
        page.find('.increase img').click()
      end
      sleep 1

      page.find('.quantity div').text.should eq '2'
      Cart.last.line_items.first.quantity.should eq 2

      within('.actions_with_quantity') do
        page.find('.decrease img').click()
      end
      sleep 1

      page.find('.quantity div').text.should eq '1'
      Cart.last.line_items.first.quantity.should eq 1

      within('.actions_with_quantity') do
        page.find('.decrease img').click()
      end
      sleep 1

      page.should have_content 'Корзина очищена'
      current_path.should == products_path
    end

    it 'should remove product & cart too' do
      within('.delete_line_item') do
        page.find('a').click()
      end
      sleep 1

      page.should have_content 'Ваша корзина пуста!'
      current_path.should == products_path
    end

    it 'ordering' do
      within('#my_cart') do
        click_on('Оформить заказ')
      end
      page.should have_content 'Оформление заказа:'
      current_path.should == new_order_path
    end

    it 'working links on top of menu bar' do
      visit root_path
      current_path.should == root_path

      page.find('.basket_btn_order').click()
      page.should have_content('Моя Корзина:')
    end

  end
end
