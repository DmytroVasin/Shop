# coding: utf-8
class ProductsController < ApplicationController
  def index
    find_sort_hash

    @genders   = Gender::ALL
    @categories = Category.order('category_rus ASC')
    @brands     = Brand.order('LOWER(name) ASC')
  end

  def product_search
    find_sort_hash

    current_page = params[:page]

    products = Product.selecting_by(params[:categories_params], 'categories')
                      .selecting_by_keys(params[:color_params], 'colours.common_colors')
                      .selecting_by(params[:brands_params], 'brand', 's')
                      .selecting_by(params[:gender_params], 'genders', '', 'gender')
                      .selecting_by_keys(params[:zipper_params], 'zippers')
                      .selecting_by_keys(params[:material_params], 'materials')
                      .selecting_by_keys(params[:feature_params], 'features')
                      .price_between(params[:price_between])
                      .sort_direction(params[:sort_direction], @sort_hash)

    @products = products.page(current_page).per(18).includes(:colours).includes(:brand).includes(:images)
  end

  def show
    find_product

    @product_colors = @product.colors.preload(:image)
    @images_count   = @product_colors.count > 4
    @colors_name    = @product.colours.uniq

    category = @product.first_category

    @also_like = Category.get_three_also_viewed_products_with(category, @product)
  end

  def color_picker
    find_product

    @image_link = @product.images.choose_by_color( params[:color] ).get_splited_representative_img[0] + '-p-MULTIVIEW.jpg'

    respond_to do |format|
      format.json { render json: { imgUrl: @image_link }}
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def find_sort_hash
    @sort_hash = Product::SORT_HASH
  end

end
