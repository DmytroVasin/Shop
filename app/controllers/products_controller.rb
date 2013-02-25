class ProductsController < ApplicationController

  def index

    @price_hash = { '0:150'   => '< 150',
                    '150:200' => '150 < 200',
                    '200:350' => '200 < 350',
                    '350:500' => '350 < 500',
                    '500:700' => '500 < 700',
                    '700'     => '700+' }

    @sort_array = %w(newest high low best)

    @products = Product.all

    if @sort_array.include? params[:sort_by]
      @products = Product.send(params[:sort_by])
    end


    if @price_hash.include? params[:price_between]
      arr = params[:price_between].split(':')
      arr[1] = '10000' if arr[1].nil? # TODO: 10000 - this is max price ( how to remove it? or let it stay ?)

      @products = @products.price_between(arr[0], arr[1])
    end

  end

end