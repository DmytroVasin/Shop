# coding: utf-8
class ProductsController < ApplicationController
  before_filter :find_product, only: [:show, :color_picker]

  def index
    @flag = params[:flag] == "true" ? true : false;

    @sort_hash = Product::SORT_HASH
    @genders   = Gender::ALL

    @categories = Category.all
    @brands     = Brand.joins(:products).group('brands.id').order('name ASC')

    products = Product.selecting_by(params[:categories_params], 'categories')
                       .includes(:colours)
                       .selecting_by_keys(params[:color_params], 'colours.common_colors')
                       .selecting_by(params[:brands_params], 'brand', 's')
                       .selecting_by(params[:gender_params], 'genders', '', 'gender')
                       .selecting_by_keys(params[:zipper_params], 'zippers')
                       .selecting_by_keys(params[:material_params], 'materials')
                       .selecting_by_keys(params[:feature_params], 'features')
                       .price_between(params[:price_between])
                       .sort_direction(params[:sort_direction], @sort_hash)


    @products = unless products.kind_of?(Array)
                  products.page(params[:page]).per(18)
                else
                  Kaminari.paginate_array(products).page(params[:page]).per(18)
                end

    session[:products_params] = params

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @product_colors = @product.colors.preload(:image)
    @images_count   = @product_colors.count > 4
    @colors_name    = @product.colours.uniq
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
