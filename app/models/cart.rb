class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product, cart_id, color)
    current_item = LineItem.where(product_id: product.id, cart_id: cart_id, color: color).first
    if current_item
      current_item.quantity += 1
      current_item.price    += product.price
    else
      current_item = line_items.build(product_id: product.id, price: product.price, color: color)
    end

    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.price*item.quantity }
  end

  def decrease(line_item_id)
    current_item = LineItem.find(line_item_id)
    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end

    current_item
  end

  def increase(line_item_id)
    current_item          = LineItem.find(line_item_id)
    current_item.quantity += 1
    current_item
  end

end
