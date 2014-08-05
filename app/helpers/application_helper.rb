# coding: utf-8
module ApplicationHelper
  def is_last_on_page product_counter
    (product_counter-2)%3 == 0 ? 'last' : ''
  end

  def current_page path
    'current_page' if current_page?(path)
  end

  def pluralize_ru(count, string, without_number=true)
    line_begining_from = if without_number
      "#{count} #{string}"
    else
      "#{string}"
    end

    if count == 1
      line_begining_from
    elsif (2..4).member?(count)
      line_begining_from << "а"
    else
      line_begining_from << "ов"
    end
  end

  def back_to_products(title, add_bootstrap = true)
    class_name = add_bootstrap ? 'bootstrap_btn' : ''
    link_to title, products_path, class: class_name
  end

  def sortable(column, title = nil, model = 'Product')
    title     ||= column.titleize
    direction = column == sort_column(model) && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(sort: column, direction: direction, page: nil), style: "color: red;"
  end


  def show_list_image(product)
    if product.images.empty?
      no_image
    else
      product.images.last.middle.split('-')[0] + '-p-MULTIVIEW.jpg'
    end
  end

  def show_list_image_large(product)
    if product.images.empty?
      no_image
    else
      product.images.last.middle.split('-')[0] + '-p-2x.jpg'
    end
  end

  def small_image_by_id(src)
    id = src.split('/')[-1].to_i
    product = Product.where(id: id).first
    product ? small_image_by_product(product) : no_image
  end

  def small_image_by_product(product)
    product.images.try(:first).try(:small) || no_image
  end

  def best_sellers_tag(id, value, count)
    disabling = ( count >= 8 && value == false )
    check_box_tag 'best_sellers', value, value, disabled: disabling, data: { product_id: id }
  end

  def image_with_link url_id
    link_to url_id do
      image_tag small_image_by_id(url_id), class: 'cart_image'
    end
  end

  def title_of_product id
    Product.where(id: id).first.try(:title)
  end

  def no_image
    '/assets/no_image_yet.jpg'
  end

  def rus_name obj
    obj.name_rus ? obj.name_rus : content_tag(:span, obj.name, class: 'text-error')
  end

  def rus_main en_color
    Colour::COMMON_COLORS_HASH[en_color]
  end

  def rus_name_by color
    Colour.find_by_name(color).name_rus
  end

  def find_correct_image_for line_item
    line_item.product.images.includes(:colours).where(colours: {name: line_item.color}).all.first.small
  end

  def prepayment payment_method
    if payment_method == '0.1'
      'Полная (100%) - скидка 10%'
    else
      'Частичная (30%) - скидка 0%'
    end
  end

  def discount payment_method
    case payment_method
    when '0.1'
      '10%'
    when '0'
      '0%'
    end
  end

  def real_discount payment_method
    1 - payment_method.to_f
  end

  def prepay total_price, payment_method
    prepay_ = case payment_method
    when '0.1'
      0.9
    when '0'
      0.3
    end
    prepay_ * total_price
  end

  def real_price order
    order.total_price.to_f * order.payment_method.to_f
  end

  def total_price_with_discount total_price, payment_method
    total_price * real_discount(payment_method)
  end

  def balance total_price, payment_method
    full_price = total_price_with_discount(total_price, payment_method )
    prepay = prepay(total_price, payment_method)
    (full_price - prepay).round(2).to_i
  end

  def percentage_discount old_price, new_price
    (100 - (100 * new_price) / old_price).to_i
  end

  def regulate_length title
    title.truncate(27)
  end

  def hidden_rank score, voters_count
    if score.zero?
      score
    else
      number_with_precision(score.to_f/voters_count)
    end
  end
end
