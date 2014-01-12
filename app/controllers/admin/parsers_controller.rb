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

    source_file_text.scan(/^@pImgs.*/).each {|x| instance_eval(x) }

    @product = Product.new()
    @product.price = page.css('#priceSlot .price').first.content[1..-1] unless page.css('#priceSlot .price').blank?
    @product.title = page.css('.fn').first.content unless page.css('.fn').blank?
    @product.link_href = source.to_s

    @visible_colors = []
    page.css('#colors option').each do |d|
      @visible_colors << Colour.where( name: d.content ).first_or_create
    end

    single_color = page.css('#colors .note').first
    unless single_color.blank?
      @visible_colors << Colour.where( name: single_color.content ).first_or_create
    end

    page.css('#breadcrumbs a').each_with_index do |link, index|
      @product.categories << Category.where( name: link.content ).first_or_create if index == 2
      @product.brand = Brand.where( name: link.content ).first_or_create if index == 3
    end

    video_href = page.css('#video a')
    @product.video_href = video_href.first['href'].gsub("&autoPlays=true", "") unless video_href.blank?
    @colors  = @product.colours.group_by(&:name).keys

    @success = @product.save

    if @success
      @pImgs.each_with_index do |x,index|
        current_color_id = @visible_colors[index].id

        x[1]["MULTIVIEW"].each_with_index do |z, index|
          current_image = Image.create({ small:  x[1]["MULTIVIEW_THUMBNAILS"].values[index],
                                         middle: x[1]["MULTIVIEW"].values[index],
                                         large:  x[1]["2x"].values[index] })
                                         # large:  x[1]["4x"].values[index][:filename] })

          @product.colors.create( colour_id: current_color_id, image_id: current_image.id )
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to admin_parsers_path, notice: 'Item was successfully created' }
      format.js
    end
  end
end
