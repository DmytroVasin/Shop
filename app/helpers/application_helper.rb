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

  def middle_image(product)
    if product.images.empty?
      '/assets/no_image_yet.jpg'
    else
      product.images.first.middle
    end
  end

  def small_image_by_id(id)
    product = Product.find(id)
    product ? product.images.first.small : '/assets/no_image_yet.jpg'
  end

  def best_sellers_tag(id, value, count)
    disabling = ( count >= 4 && value == false )
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
end
