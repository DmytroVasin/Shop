class Admin::ParsersController < Admin::BaseController
	before_filter :authenticate_admin!

  require 'open-uri'
  require 'nokogiri'

  def index
  end

  def get_product
		source = params['remote_url']
    page = Nokogiri::HTML(open(source.to_s))

	  data = Hash.new
    data['price'] = page.css('#priceSlot .price').first.content[1..-1]
    data['brand'] = page.css('.brand').first.content
    data['title'] = page.css('.fn').first.content


    data['colors'] = [];
    page.css('#colors option').each do |d|
	   	data['colors'] << d.content
    end

    brand = Brand.where( name: data['brand'] ).first_or_create


   	Rails.logger.info 'data  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
   	Rails.logger.info brand
   	Rails.logger.info 'data  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'

    render :index
  end
end
