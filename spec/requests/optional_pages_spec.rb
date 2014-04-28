require 'spec_helper'

describe 'Optional pages', js: true do
  before :each do
    visit root_path
  end

  it 'about_us' do
    visit about_us_path
    page.should have_content('Карта сайта')
    page.should have_content('О нас')
    page.should have_content('В магазине «VaKo» Вы найдете огромный выбор дорожной')
  end

  it 'to_order' do
    visit to_order_path
    page.should have_content('Карта сайта')
    page.should have_content('Как заказать')
    page.should have_content('Для покупки товара необходимо на сайте выбрать')
  end

  it 'warranties' do
    visit warranties_path
    page.should have_content('Карта сайта')
    page.should have_content('Гарантии доставки')
    page.should have_content('Интернет магазин VaKo гарантирует, что все фотографии')
  end

  it 'faqs' do
    visit faqs_path
    page.should have_content('Карта сайта')
    page.should have_content('Вопрос/Ответ')
    page.should have_content('Могу не платить 30% предоплату, а сразу 100% при получении?')
  end

  it 'policy' do
    visit policy_path
    page.should have_content('Карта сайта')
    page.should have_content('Политика конфиденциальности')
    page.should have_content('Администрация Сайта признает важность конфиденциальности')
  end

  it 'delivery' do
    visit delivery_path
    page.should have_content('Карта сайта')
    page.should have_content('Доставка')
    page.should have_content('Доставка товара осуществляется до')
  end

  it 'action' do
    visit action_path
    page.should have_content('Карта сайта')
    page.should have_content('Акции')
    page.should have_content('Постоянным клиентам скидка 3%')
  end

  it 'contacts' do
    visit contacts_path
    page.should have_content('Карта сайта')
    page.should have_content('Контакты:')
    page.should have_content('Ваше письмо получит служба поддержки. И мы постараемся решить вопрос максимально быстро')
  end

  it 'materials' do
    visit materials_path
    page.should have_content('Карта сайта')
    page.should have_content('Материалы')
    page.should have_content('Полиэстер относится к группе широко используемых продуктов')
  end

  it 'reviews with correct data' do
    visit reviews_path
    page.should have_content('Карта сайта')
    page.should have_content('Отзывы:')
    page.should have_content('Добавить отзыв:')
    page.should_not have_content 'Cроки доставки были нормальными!'

    fill_in 'review_full_name', with: 'Юлия Гришковец'
    fill_in 'review_address', with: 'г. Владимир-Волынский, Волынская обл.'
    fill_in 'review_url_id', with: "http://vako.dn.ua/products/1"
    fill_in 'review_delivery_time', with: 'Cроки доставки были нормальными!'

    click_on 'Отправить'

    within '.review_item' do
      page.should have_content 'Юлия Гришковец'
      page.should have_content 'г. Владимир-Волынский, Волынская обл.'
      page.should have_content 'Cроки доставки были нормальными!'
    end
  end

  it 'reviews page with incorrect data' do
    visit reviews_path

    within '#new_review' do
      page.all(".field_with_errors").count.should eql(0)

      fill_in 'review_full_name', with: 'Юлия Гришковец'
      click_on 'Отправить'

      page.all(".field_with_errors").count.should eql(2)
    end
  end
end
