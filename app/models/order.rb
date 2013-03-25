# encoding: utf-8
class Order < ActiveRecord::Base
  attr_accessible :address,
                  :email,
                  :name,
                  :surname,
                  :pay_type,
                  :phone,
                  :additional_phone,
                  :region,
                  :city,
                  :info,
                  :terms_of_service

  PAYMENT_TYPES = ["Новая почта - наложенный плтёж", "Укр Почта"]
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

  validates :terms_of_service, acceptance: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  validates :region, inclusion: REGIONS
  validates :address, :email, :name, :surname, :phone, :region, :city, presence: true
  validates :email, length: { minimum: 7, maximum: 254 },
                    format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :name, :surname, length: { minimum: 2, maximum: 254}
  validates :phone, numericality: true
  validates :additional_phone, numericality: true, allow_blank: true

  def input_line_items_to_order(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
      # In table line_item in each item we remove cart.id and add order_id
    end
  end
end
