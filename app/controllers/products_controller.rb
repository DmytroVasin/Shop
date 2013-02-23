class ProductsController < ApplicationController

  def index

    @products = Product.all

    @products = Product.new if params[:sort] == 'new'
    @products = Product.high if params[:sort] == 'high'
    @products = Product.low if params[:sort] == 'low'
    @products = Product.best if params[:sort] == 'best'

    #@products = Product.by_lower_price(params[:price]) if params[:price].present?
    #@products = Product.in_stock if params[:in_stock].present?
  end

  def create

  end
end