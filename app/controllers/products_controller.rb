# coding: utf-8
class ProductsController < ApplicationController

  def index
    @flag = params[:flag] == "true" ? true : false;

    @sort_hash = hash_of_sort

    @categories = Category.all
    @brands  = Brand.joins(:products).group('brands.id').order('name ASC')
    @genders = Gender.joins(:products).group('genders.id').order('gender ASC')
    # @colors  = Colour.joins(:colors).order('name ASC').uniq(&:id)

    @products = Product.selecting_by(params[:categories_params], 'categories')
                       .includes(:colours)
                       .selecting_by_color(params[:color_params])
                       .selecting_by(params[:brands_params], 'brand', 's')
                       .selecting_by(params[:gender_params], 'genders', '', 'gender')
                       .selecting_by_zipper(params[:zipper_params])
                       .selecting_by_material(params[:material_params])
                       .selecting_by_features(params[:feature_params])
                       .price_between(params[:price_between])
                       .sort_direction(params[:sort_direction], @sort_hash)
                       # .uniq

    # !!!!
    # Product.find_by_sql("SELECT * FROM products INNER JOIN colors_products ON colors_products.product_id = products.id INNER JOIN colors ON colors.id = colors_products.color_id WHERE (name = 'Red' or name = 'Black') AND (price between 10 and 12 or price between 90 and 100)").count
    # Product.joins(:categories).where("categories.name = 'Makeup' OR categories.name = 'Duffle Bags'").joins(:brand).where("brands.name = 'Collistar' OR brands.name = 'Elizabeth Arden'").joins(:genders).where("genders.gender = 'Women' OR genders.gender = 'Girls'").joins(:colors).where("colors.name = 'Red' OR colors.name = 'Black'").where("price between 10 AND 20 OR price between 90 AND 110").scoped
    # !!!!

    unless @products.kind_of?(Array)
      @products = @products.page(params[:page]).per(18)
    else
      @products = Kaminari.paginate_array(@products).page(params[:page]).per(18)
    end

    session[:products_params] = params

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @product        = Product.find(params[:id])
    @product_colors = @product.colors.preload(:image)
    @images_count   = @product_colors.count > 4
    @colors_name    = @product.colours.uniq
  end

  def color_picker
    product = Product.find(params[:itemId])
    product.colours.where("common_colors ? :key", key: params[:color] )


    @image_link = product.images.joins(:colours).where("common_colors ? :key", key: params[:color] ).last.middle.split('-')[0] + '-p-MULTIVIEW.jpg'


    respond_to do |format|
      format.json { render json: { imgUrl: @image_link }}
    end
  end

  private

  def hash_of_sort
    { 'Лучшее'    => 'best',
      'Цена low'  => 'low',
      'Цена high' => 'high',
      'Новое'     => 'newest' }
  end
end
