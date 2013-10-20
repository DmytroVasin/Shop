class Admin::ParsersController < Admin::BaseController
	before_filter :authenticate_admin!

  require 'open-uri'
  require 'nokogiri'

  def index
  end

  def get_product
		source = params['remote_url']
    page = Nokogiri::HTML(open(source.to_s))

	  product = Product.new()
    product.price = page.css('#priceSlot .price').first.content[1..-1]
    product.title = page.css('.fn').first.content

    # brand = page.css('.brand').first.content
    # product.brand = Brand.where( name: brand ).first_or_create

    page.css('#colors option').each do |d|
      product.colors << Color.where( name: d.content ).first_or_create
    end

    page.css('#crumbs a').each_with_index do |link, index|
      product.categories << Category.where( name: 'link.content' ).first_or_create if index == 2
      product.brand = Brand.where( name: link.content ).first_or_create if index == 3
    end

    product.save
    Rails.logger.info 'data  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    Rails.logger.info 'data  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'

    render :index
  end
end
