class ProductsController < ApplicationController

  def index

    @price_hash = { '0:150'    => '< 150',
                    '150:200'  => '150 < 200',
                    '200:350'  => '200 < 350',
                    '350:500'  => '350 < 500',
                    '500:700'  => '500 < 700',
                    '700:1000' => '700+' }


    @products = Product.all

    @products = Product.new if params[:sort] == 'new'
    @products = Product.high if params[:sort] == 'high'
    @products = Product.low if params[:sort] == 'low'
    @products = Product.best if params[:sort] == 'best'


    if @price_hash.include? params[:price]
      arr       = params[:price].split(':')
      @products = Product.price_between(arr[0], arr[1])
    end

  end

end