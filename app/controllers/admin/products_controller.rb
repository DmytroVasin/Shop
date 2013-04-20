class Admin::ProductsController < Admin::BaseController
  before_filter :authenticate_admin!
  helper_method :sort_column, :sort_direction

  def index
    #@products = Product.search(params[:search]).page(params[:page]).per(10)
    @products = Product.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(10)
    #@products = @products if params[:sort]
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

    if @product.update_attributes(params[:product])
      flash[:notice] = 'Perfume updated'
      redirect_to admin_product_path(@product.id)
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy
    redirect_to admin_products_path
  end





  private

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
