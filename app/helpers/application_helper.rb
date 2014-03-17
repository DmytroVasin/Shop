# coding: utf-8
module ApplicationHelper
  def current_page(path)
    'current_page' if current_page?(path)
  end

  def pluralize_ru(count, string)
    if count == 1
      "#{count} #{string}"
    elsif (2..4).member?(count)
      "#{count} #{string}ара"
    else
      "#{count} #{string}ов"
    end
  end

  def back_to_products(title, class_name = nil)
    if session[:products_params]
      session[:products_params][:format] = 'html'
      link_to title, session[:products_params], class: class_name
    else
      link_to title, products_path, class: class_name
    end
  end

  def sortable(column, title = nil, model = 'Product')
    title     ||= column.titleize
    direction = column == sort_column(model) && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(sort: column, direction: direction, page: nil), style: "color: red;"
  end


  def show_list_image(product)
    if product.images.empty?
      '/assets/no_image_yet.jpg'
    else
      product.images.last.middle.split('-')[0] + '-p-MULTIVIEW.jpg'
    end
  end

  def show_list_image_large(product)
    if product.images.empty?
      '/assets/no_image_yet.jpg'
    else
      product.images.last.middle.split('-')[0] + '-p-2x.jpg'
    end
  end

  def small_image_by_id(id)
    product = Product.find(id)
    small_image_by_product(product) if product
  end

  def small_image_by_product(product)
    product.images.try(:first).try(:small) || '/assets/no_image_yet.jpg'
  end

  def best_sellers_tag(id, value, count)
    disabling = ( count >= 8 && value == false )
    check_box_tag 'best_sellers', value, value, disabled: disabling, data: { product_id: id }
  end

  def set_value_by_params(gender)
    return gender.in? params[:gender_params] if params[:gender_params]
    false
  end

  def url_to_product(id)
    "products/#{id}"
  end

  def title_of_product(id)
    product = Product.find(id)
    product ? product.title : 'incorrect url'
  end

  def rus_name(obj)
    obj.name_rus ? obj.name_rus : content_tag(:span, obj.name, class: 'text-error')
  end

  def rus_name_by color
    Colour.find_by_name(color).name_rus
  end

  def find_correct_image_for line_item
    line_item.product.images.includes(:colours).where(colours: {name: line_item.color}).all.first.small
  end

  def prepayment(payment_method)
    if payment_method == 0.9
      'Полная (100%) - скидка 10%'
    else
      'Частичная (30%) - без скидок'
    end
  end

  def real_price(order)
    order.total_price.to_f * order.payment_method.to_f
  end
end
