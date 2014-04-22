# encoding: UTF-8

FactoryGirl.define do
  factory :product do
    sequence(:title) { Populator.words(2..3).titleize }
    sequence(:description) { Populator.sentences(5) }
    price 140.80
    sequence(:old_price) { price + 100.10 }
    rank 10

    association :brand

    categories {[FactoryGirl.create(:category)]}

    trait :bestseller do
      bestseller true
    end

    trait :with_bag_sport do
      after(:create) do |product|
        product.colors << FactoryGirl.create(:grey_bag_sport)
      end
    end

    trait :with_bag_on_wheels do
      after(:create) do |product|
        product.colors << FactoryGirl.create(:granit_bag_on_wheels)
      end
    end

    factory :bestseller_with_bag_sport,     traits: [:bestseller, :with_bag_sport]
    factory :bestseller_with_bag_on_wheels, traits: [:bestseller, :with_bag_on_wheels]
  end


  # Categories
  factory :category do
    name 'Handbag'
    category_rus 'Ручная кладь'
  end


  # Brands:
  factory :brand do
    name 'Dior'
  end


  # Colors:
  factory :granit_bag_on_wheels, class: Color do
    association :colour, factory: :granit
    association :image, factory: :bag_on_wheels
  end

  factory :grey_bag_sport, class: Color do
    association :colour, factory: :grey
    association :image, factory: :bag_sport
  end


  # Colours:
  factory :granit, class: Colour do
    name 'Granite'
    name_rus 'Гранит'
  end

  factory :grey, class: Colour do
    name 'Grey'
    name_rus 'Серый'
  end


  # Images:
  factory :bag_sport, class: Image do
    small  'http://www.zappos.com/images/z/2/7/5/8/2/6/2758265-p-MULTIVIEW_THUMBNAILS.jpg'
    middle 'http://www.zappos.com/images/z/2/7/5/8/2/6/2758265-p-MULTIVIEW.jpg'
    large  'http://www.zappos.com/images/z/2/7/5/8/2/6/2758265-p-2x.jpg'
  end

  factory :bag_on_wheels, class: Image do
    small  'http://www.zappos.com/images/z/2/6/2/4/8/6/2624867-p-MULTIVIEW_THUMBNAILS.jpg'
    middle 'http://www.zappos.com/images/z/2/6/2/4/8/6/2624867-p-MULTIVIEW.jpg'
    large  'http://www.zappos.com/images/z/2/6/2/4/8/6/2624867-p-2x.jpg'
  end

end
