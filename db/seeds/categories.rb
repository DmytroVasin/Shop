module Seeds
  def create_categories
    ['For Her', 'For Him', 'Specials', 'Gift set'].each do |name|
      Category.create(name: name)
    end
  end

  module_function :create_categories
end