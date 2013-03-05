module ApplicationHelper
  def current_page(path)
    'current_page' if current_page?(path)
  end
end
