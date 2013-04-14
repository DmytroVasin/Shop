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

  def sortable(column, title = nil)
    title     ||= column.titleize
    direction = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction }
  end
end
