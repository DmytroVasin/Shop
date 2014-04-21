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

  has_many :line_items, dependent: :destroy

  phony_normalize :phone, default_country_code: 'UA'

  include Order::OrderConstants
  include Order::OrderValidations

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
