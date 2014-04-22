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

    trait :with_zebra_wallet_kate do
      after(:create) do |product|
        product.colors << FactoryGirl.create(:zebra_wallet_kate)
      end
    end

    trait :with_wallet_bleecker do
      after(:create) do |product|
        product.colors << FactoryGirl.create(:pink_wallet_bleecker)
      end
    end

    trait :with_laptop_vivienne do
      after(:create) do |product|
        product.colors << FactoryGirl.create(:orange_laptop_vivienne)
      end
    end

    trait :with_laptop_slim do
      after(:create) do |product|
        product.colors << FactoryGirl.create(:red_laptop_slim)
      end
    end

    factory :bestseller_with_bag_sport,         traits: [:bestseller, :with_bag_sport]
    factory :bestseller_with_bag_on_wheels,     traits: [:bestseller, :with_bag_on_wheels]
    factory :bestseller_with_zebra_wallet_kate, traits: [:bestseller, :with_zebra_wallet_kate]
    factory :bestseller_with_wallet_bleecker,   traits: [:with_wallet_bleecker]
    factory :bestseller_with_laptop_vivienne,   traits: [:with_laptop_vivienne]
    factory :bestseller_with_laptop_slim,       traits: [:with_laptop_slim]
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

  factory :zebra_wallet_kate, class: Color do
    association :colour, factory: :zebra
    association :image, factory: :wallet_kate
  end

  factory :pink_wallet_bleecker, class: Color do
    association :colour, factory: :pink
    association :image, factory: :wallet_bleecker
  end

  factory :orange_laptop_vivienne, class: Color do
    association :colour, factory: :orange
    association :image, factory: :laptop_vivienne
  end

  factory :red_laptop_slim, class: Color do
    association :colour, factory: :red
    association :image, factory: :laptop_slim
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

  factory :zebra, class: Colour do
    name 'Zebra'
    name_rus 'Зебра'
  end

  factory :pink, class: Colour do
    name 'Pink'
    name_rus 'Розовый'
  end

  factory :orange, class: Colour do
    name 'Orange'
    name_rus 'Оранжевый'
  end

  factory :red, class: Colour do
    name 'Red'
    name_rus 'Красный'
  end


  # Images:
  factory :bag_on_wheels, class: Image do
    small  'http://www.zappos.com/images/z/2/6/2/4/8/6/2624867-p-MULTIVIEW_THUMBNAILS.jpg'
    middle 'http://www.zappos.com/images/z/2/6/2/4/8/6/2624867-p-MULTIVIEW.jpg'
    large  'http://www.zappos.com/images/z/2/6/2/4/8/6/2624867-p-2x.jpg'
  end

  factory :bag_sport, class: Image do
    small  'http://www.zappos.com/images/z/2/7/5/8/2/6/2758265-p-MULTIVIEW_THUMBNAILS.jpg'
    middle 'http://www.zappos.com/images/z/2/7/5/8/2/6/2758265-p-MULTIVIEW.jpg'
    large  'http://www.zappos.com/images/z/2/7/5/8/2/6/2758265-p-2x.jpg'
  end

  factory :wallet_kate, class: Image do
    small  'http://www.zappos.com/images/z/2/5/0/5/1/3/2505138-4-MULTIVIEW_THUMBNAILS.jpg'
    middle 'http://www.zappos.com/images/z/2/5/0/5/1/3/2505138-4-MULTIVIEW.jpg'
    large  'http://www.zappos.com/images/z/2/5/0/5/1/3/2505138-4-2x.jpg'
  end

  factory :wallet_bleecker, class: Image do
    small  'http://www.zappos.com/images/z/2/6/4/9/5/9/2649594-p-MULTIVIEW_THUMBNAILS.jpg'
    middle 'http://www.zappos.com/images/z/2/6/4/9/5/9/2649594-p-MULTIVIEW.jpg'
    large  'http://www.zappos.com/images/z/2/6/4/9/5/9/2649594-p-2x.jpg'
  end

  factory :laptop_vivienne, class: Image do
    small  'http://www.zappos.com/images/z/2/1/4/1/6/1/2141611-3-MULTIVIEW_THUMBNAILS.jpg'
    middle 'http://www.zappos.com/images/z/2/1/4/1/6/1/2141611-3-MULTIVIEW.jpg'
    large  'http://www.zappos.com/images/z/2/1/4/1/6/1/2141611-3-2x.jpg'
  end

  factory :laptop_slim, class: Image do
    small  'http://www.zappos.com/images/z/1/9/4/8/6/7/1948673-4-MULTIVIEW_THUMBNAILS.jpg'
    middle 'http://www.zappos.com/images/z/1/9/4/8/6/7/1948673-4-MULTIVIEW.jpg'
    large  'http://www.zappos.com/images/z/1/9/4/8/6/7/1948673-4-2x.jpg'
  end

end
