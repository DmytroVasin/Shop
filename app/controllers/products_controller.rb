# coding: utf-8
class ProductsController < ApplicationController

  def index

    @price_hash = { '0:150'   => '< 150',
                    '150:200' => '150 < 200',
                    '200:350' => '200 < 350',
                    '350:500' => '350 < 500',
                    '500:700' => '500 < 700',
                    '700'     => '700+' }

    @sort_hash = { 'Лучшее'    => 'best',
                   'Цена low'  => 'low',
                   'Цена high' => 'high',
                   'Новое'     => 'newest' }

    @sort_method_array = %w(newest high low best)

    @categories  = Category.all

    @brands_with_product = Brand.joins(:products)
    @brands      = @brands_with_product.uniq!

    @brands_left  = @brands_with_product.random_by_id_shuffle(10)
    @brands_right = @brands_with_product.random_by_id_shuffle(10)

    @products = Product.order('created_at DESC').page(params[:page]).per(6)

    if @sort_method_array.include? params[:sort_by]
      @products = Product.send(params[:sort_by]).page(params[:page]).per(6)
      #TODO: in this scope we use order - thats why we use Product model rather than @product
    end

    if @price_hash.include? params[:price_between]
      arr = params[:price_between].split(':')
      arr[1] = '10000' if arr[1].nil? # TODO: 10000 - this is max price ( how to remove it? or let it stay ?)

      @products = @products.price_between(arr[0], arr[1])
    end

    if @categories.map(&:name).include? params[:product_type]
      @products = @products.by_category_name(params[:product_type])
    end

    if @brands.map(&:name).include? params[:brand_type]
      @products = @products.by_brands_name(params[:brand_type])
    end
  end

end