# encoding: utf-8
class Order < ActiveRecord::Base
  attr_accessible :address,
                  :email,
                  :name,
                  :surname,
                  :delivery,
                  :phone,
                  :additional_phone,
                  :region,
                  :city,
                  :info,
                  :terms_of_service,
                  :payment_method,
                  :status,
                  :adm_info

  STATUSES      = ['Заказано', 'Отправленно']
  PAYMENT_METHOD= [['Полная (100%)', 0.9], ['Частичная (30%)', 1]]
  REGIONS       = [
      "Винницкая область",
      "Волынская область",
      "Днепропетровская область",
      "Донецкая область",
      "Житомирская область",
      "Закарпатская область",
      "Запорожская область",
      "Ивано-Франковская область",
      "Киевская область",
      "Кировоградская область",
      "Луганская область",
      "Львовская область",
      "Николаевская область",
      "Одесская область",
      "Полтавская область",
      "Ровенская область",
      "Сумская область",
      "Тернопольская область",
      "Харьковская область",
      "Херсонская область",
      "Хмельницкая область",
      "Черкасская область",
      "Черниговская область",
      "Черновицкая область",
      "АР Крым"
  ]

  has_many :line_items, dependent: :destroy

  phony_normalize :phone, default_country_code: 'UA'
  validates :phone, phony_plausible: true


  validates :terms_of_service, acceptance: true
  validates :region, inclusion: REGIONS
  validates :status, inclusion: STATUSES
  validates :email, :name, :surname, :phone, :region, :city, :payment_method, presence: true
  validates :email, length: { minimum: 7, maximum: 254 },
            format:         { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                              message: "must be a valid email address" }
  validates :name, :surname, length: { minimum: 2, maximum: 254 }

  validates :phone, numericality: true

  def input_line_items_to_order(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
      # In table line_item in each item we remove cart.id and add order_id
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.price*item.quantity }
  end
end
