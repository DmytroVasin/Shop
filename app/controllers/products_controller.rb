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


    @products = Product.order('created_at DESC')



    price_between_array = params[:price_between] ? params[:price_between] : []

    array_query = [];
    sql_query_start = 'select * from products where price between ? and ?'
    if price_between_array.count > 0
      (price_between_array.count - 1).times do
        sql_query_start << " or price between ? and ?"
      end

      array_query.push(sql_query_start)

      price_between_array.each do |pb|
        string = pb.split(':')
        array_query.push(string[0].to_i)
        array_query.push(string[1].to_i)
      end
    end

    # @products = Product.find_by_sql [ "select * from products where price between ? and ? or price between ? and ?", 10, 20, 90, 105 ]
    @products = Product.find_by_sql array_query if array_query.present?

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
    { '0:150'    => '< 150',
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