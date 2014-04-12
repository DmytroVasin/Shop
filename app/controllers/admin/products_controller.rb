class Admin::ProductsController < Admin::BaseController
  before_filter :authenticate_admin!
  before_filter :find_product, only: [:show, :edit, :update, :destroy, :update_features]

  def index
    @best_count = Product.count_of_best_sellers.count
    @products = Product.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(10)
  end

  def show
    @colors  = @product.colours.group_by(&:name_rus).keys
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
  end

  def update
    respond_to do |format|
      if @product.update_attributes!(params[:product])
        flash[:notice] = 'Product updated'
        format.html { redirect_to admin_product_path(@product.id) }
        format.js
      else
        format.html { render 'new' }
      end
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path
  end

  def best_sell
    if params[:checked].in? ["true", "false"]
      Product.find(params[:product_id]).update_attributes({ bestseller: params[:checked] })
    end

    @best_count = Product.count_of_best_sellers.count
    @products = Product.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(10)
    render :index
  end

  def update_features
    acceptedMaterialArray, acceptedZipperArray, acceptedFeatureArray  = params[:acceptedMaterialArray], params[:acceptedZipperArray], params[:acceptedFeatureArray]

    materials = create_hash_by( Product::MATERIAL,     acceptedMaterialArray)
    zippers   = create_hash_by( Product::CLOSING_TYPE, acceptedZipperArray)
    features  = create_hash_by( Product::FEATURES,     acceptedFeatureArray)

    @product.update_attributes({ zippers: zippers, materials: materials, features: features })

    flash[:notice] = 'Товар успешно обновлён!'
    render js: 'window.location.reload()'
  end


  private

  def find_product
    @product = Product.find(params[:id])
  end
end
