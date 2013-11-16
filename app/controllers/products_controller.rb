# coding: utf-8
class ProductsController < ApplicationController

  def index
    # @flag = true;

    @price_hash = hash_of_prices
    @sort_hash = hash_of_sort
    @sort_method_array = @sort_hash.values

    @categories = Category.all
    @brands  = Brand.joins(:products).group('brands.id').order('name ASC')
    @genders = Gender.joins(:products).group('genders.id').order('gender ASC')
    @colors  = Color.joins(:products).group('colors.id').order('name ASC')


    @products = Product.selecting_by(params[:categories_params], 'categories').selecting_by(params[:brands_params], 'brand', 's').selecting_by(params[:gender_params], 'genders', '', 'gender').selecting_by(params[:color_params], 'colors').price_between(params[:price_between])

    # !!!!
    # Product.find_by_sql("SELECT * FROM products INNER JOIN colors_products ON colors_products.product_id = products.id INNER JOIN colors ON colors.id = colors_products.color_id WHERE (name = 'Red' or name = 'Black') AND (price between 10 and 12 or price between 90 and 100)").count
    # Product.joins(:categories).where("categories.name = 'Makeup' OR categories.name = 'Duffle Bags'").joins(:brand).where("brands.name = 'Collistar' OR brands.name = 'Elizabeth Arden'").joins(:genders).where("genders.gender = 'Women' OR genders.gender = 'Girls'").joins(:colors).where("colors.name = 'Red' OR colors.name = 'Black'").where("price between 10 AND 20 OR price between 90 AND 110").scoped
    # !!!!

    # Rails.logger.info '>>>>'*50
    # Rails.logger.info @products.count
    # Rails.logger.info '>>>>'*50

    unless @products.kind_of?(Array)
      @products = @products.page(params[:page]).per(12)
    else
      @products = Kaminari.paginate_array(@products).page(params[:page]).per(12)
    end

    session[:products_params] = params

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @product      = Product.find(params[:id])
    @images_count = @product.images.count > 4
  end


  private

  def hash_of_prices
    { '0:149'    => '< 150',
      '150:199'  => '150 < 200',
      '200:349'  => '200 < 350',
      '350:399'  => '350 < 500',
      '500:699'  => '500 < 700',
      '700:9999' => '700+' }
  end

  def hash_of_sort
    { 'Лучшее'    => 'best',
      'Цена low'  => 'low',
      'Цена high' => 'high',
      'Новое'     => 'newest' }
  end
end