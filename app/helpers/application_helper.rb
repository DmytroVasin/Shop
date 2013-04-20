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
      link_to title, session[:products_params], class: class_name
    else
      link_to title, products_path, class: class_name
    end
  end

  def sortable(column, title = nil, model = 'Product')
    title     ||= column.titleize
    direction = column == sort_column(model) && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(sort: column, direction: direction, page: nil)
  end
end
