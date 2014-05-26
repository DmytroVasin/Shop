# coding: utf-8
class ProductsController < ApplicationController
  skip_before_filter :clear_session
  before_filter :find_product, only: [:show, :color_picker]

  def index
    if params[:gender_params]
      session['products_params'] = {}
      session['products_params']['gender_params'] = params[:gender_params]
    end


    current_page = session['current_page_applyed'] || params[:page]
    session['current_page_keeped']  = params[:page] || session['current_page_applyed']

    if params[:format] == 'js'
      session['current_page_applyed'] = nil if session['current_page_applyed']
      session[:products_params] = params
    end

    @sort_hash = Product::SORT_HASH
    @genders   = Gender::ALL

    @categories = Category.all
    @brands     = Brand.order('LOWER(name) ASC')

    products = Product.selecting_by(params[:categories_params], 'categories')
                       .includes(:colours)
                       .includes(:brand)
                       .includes(:images)
                       .selecting_by_keys(params[:color_params], 'colours.common_colors')
                       .selecting_by(params[:brands_params], 'brand', 's')
                       .selecting_by(params[:gender_params], 'genders', '', 'gender')
                       .selecting_by_keys(params[:zipper_params], 'zippers')
                       .selecting_by_keys(params[:material_params], 'materials')
                       .selecting_by_keys(params[:feature_params], 'features')
                       .price_between(params[:price_between])
                       .sort_direction(params[:sort_direction], @sort_hash)


    @products = if products.kind_of?(Array)
                  # Never call?
                  products.page(current_page).per(18)
                else
                  Kaminari.paginate_array(products).page(current_page).per(18)
                end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    session['current_page_applyed'] = session['current_page_keeped']

    @product_colors = @product.colors.preload(:image)
    @images_count   = @product_colors.count > 4
    @colors_name    = @product.colours.uniq

    category = @product.first_category

    @also_like = Category.get_three_also_viewed_products_with(category, @product)
  end

  def color_picker
    @image_link = @product.images.choose_by_color( params[:color] ).get_splited_representative_img[0] + '-p-MULTIVIEW.jpg'

    respond_to do |format|
      format.json { render json: { imgUrl: @image_link }}
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

end
