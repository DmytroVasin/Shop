require 'spec_helper'

describe 'Cart', js: true do
  let!(:product_1) { create :product_bestseller_with_bag_sport }

  before :each do
    visit product_path(product_1)
    page.find('.adding_to_cart').click()

    within('#my_cart') do
      click_on('Оформить заказ')
    end

    clear_emails
    ActionMailer::Base.deliveries = []
  end

  it 'opened cart page' do
    page.should have_content 'Состав заказа:'
    page.should have_content 'Оформление заказа:'
    page.should have_content 'Общая цена товар:'
    page.should have_content 'Остаток:'
    page.should have_content 'Заполните личные данные'
    page.should have_content '10%'
    page.should have_content '140.80 грн.'
    page.should have_content '126.72 грн.'
    page.should have_content '0.00 грн.'
  end

  it 'back to cart' do
    click_on('« Обратно к корзине')
    page.should have_content('Моя Корзина:')
  end

  it 'fill in form & get email & chech opening page at the end ( with details of order )' do
    fill_in 'order_surname', with: 'aaaaaa'
    fill_in 'order_name', with: 'aaaaaa'
    fill_in 'order_email', with: 'some_email@gmail.com'

    find(:css, "#order_terms_of_service").set(true)

    fill_in 'order_phone', with: '(095) 433-4666'

    page.find('#order_region').find("option[value='Винницкая область']").select_option
    fill_in 'order_city', with: 'Винница'

    click_on('Оформить заказ')

    ActionMailer::Base.deliveries.count.should == 2

    open_email('order.vako@gmail.com')
    current_email.subject.should == 'Новый заказ! №1'
    current_email.from.should include('from@example.com')
    current_email.to.should include('order.vako@gmail.com')

    email = open_email('some_email@gmail.com')
    current_email.subject.should == 'Ваш заказ на Vako.dn.ua'
    current_email.from.should include('from@example.com')
    current_email.to.should include('some_email@gmail.com')

    page.should have_content('Ваш заказ принят!')
    page.should have_content('Ваш заказ')
    page.should have_content('Личные данные вашего заказа')
    page.should have_content('Реквизиты:')
    page.should have_content('Номер карты')
  end
end
