class Admin::ProductsController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @products = Product.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])

    if @product.save
      flash[:notice] = 'Pefume created!'
      redirect_to admin_product_path(@product.id)
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Perfume updated'
        format.html { redirect_to admin_product_path(@product.id) }
        format.js
      else
        format.html { render 'new' }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy
    redirect_to admin_products_path
  end
end
