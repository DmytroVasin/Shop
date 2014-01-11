class Admin::ParsersController < Admin::BaseController
  before_filter :authenticate_admin!

  require 'open-uri'
  require 'nokogiri'

  def index
    @product = nil
  end

  def get_product
    source = params['remote_url']
    page = Nokogiri::HTML(open(source.to_s))


    source_file_text = page.search("script")[19].text
    source_file_text.gsub!(/(^pImgs.*)/, '@\1')

    pImgsArray = source_file_text.scan(/^@pImgs.*/)
    pImgsArray.each {|x| instance_eval(x) }

    @pImgs


    @product = Product.new()
    @product.price = page.css('#priceSlot .price').first.content[1..-1] unless page.css('#priceSlot .price').blank?
    @product.title = page.css('.fn').first.content unless page.css('.fn').blank?
    @product.link_href = source.to_s

    page.css('#colors option').each do |d|
      @product.colors << Color.where( name: d.content ).first_or_create
    end

    single_color = page.css('#colors .note').first
    unless single_color.blank?
      @product.colors << Color.where( name: single_color.content ).first_or_create
    end

    page.css('#breadcrumbs a').each_with_index do |link, index|
      @product.categories << Category.where( name: link.content ).first_or_create if index == 2
      @product.brand = Brand.where( name: link.content ).first_or_create if index == 3
    end

    video_href = page.css('#video a')
    @product.video_href = video_href.first['href'].gsub("&autoPlays=true", "") unless video_href.blank?

    page.search('#video').remove
    page.css('#productImages ul li').each do |source|
      @product.images << Image.create({ small: source.search('img').first['src'],
                                        middle: source.search('a').first['href'],
                                        large: source.search('a').first['href'].sub("MULTIVIEW", "4x") })
    end

    @success = @product.save

    respond_to do |format|
      format.html { redirect_to admin_parsers_path, notice: 'Item was successfully created' }
      format.js
    end
  end
end
