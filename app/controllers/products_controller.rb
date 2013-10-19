# coding: utf-8
class ProductsController < ApplicationController

  def index
    @price_hash = hash_of_prices
    @sort_hash = hash_of_sort
    @sort_method_array = @sort_hash.values

    @categories = Category.all
    @brands = Brand.joins(:products).group('brands.id').order('name ASC')
    @genders = Gender.joins(:products).group('genders.id').order('gender ASC')


    @products = Product.order('created_at DESC').page(params[:page]).per(12)

    @brands_left  = @brands.random_by_id_shuffle(10)
    @brands_right = @brands.random_by_id_shuffle(10)

    if @sort_method_array.include? params[:sort_by]
      @products = Product.send(params[:sort_by]).page(params[:page]).per(12)
      #TODO: in this scope we use order - thats why we use Product model rather than @product
    end

    if @price_hash.include? params[:price_between]
      arr = params[:price_between].split(':')
      arr[1] = '10000' if arr[1].nil? # TODO: 10000 - this is max price ( how to remove it? or let it stay ?)

      @products = @products.price_between(arr[0], arr[1])
    end

    if @brands.map(&:name).include? params[:brand_type]
      @products = @products.by_brands_name(params[:brand_type])
    end

    session[:products_params] = params
  end

  def show
    @product      = Product.find(params[:id])
    brands        = Brand.joins(:products)
    @brands_left  = brands.random_by_id_shuffle(10)
    @brands_right = brands.random_by_id_shuffle(10)
  end


  private

    def hash_of_prices
      { '0:150'   => '< 150',
        '150:200' => '150 < 200',
        '200:350' => '200 < 350',
        '350:500' => '350 < 500',
        '500:700' => '500 < 700',
        '700'     => '700+' }
    end

    def hash_of_sort
      { 'Лучшее'    => 'best',
        'Цена low'  => 'low',
        'Цена high' => 'high',
        'Новое'     => 'newest' }
    end
end