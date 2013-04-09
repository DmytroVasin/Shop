class Admin::BrandsController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @brands = Brand.order('name').page(params[:page]).per(10)
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(params[:brand])

    if @brand.save
      redirect_to admin_brands_path, notice: 'Brand created'
    else
      render 'new'
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy

    redirect_to admin_brands_path, notice: 'Brand deleted'
  end
end
