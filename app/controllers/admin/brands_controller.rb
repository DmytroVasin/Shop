class Admin::BrandsController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(params[:brand])

    if @brand.save
      flash[:notice] = 'Brand created'
      redirect_to admin_brands_path
    else
      render 'new'
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy

    flash[:notice] = 'Brand deleted'
    redirect_to admin_brands_path
  end
end
