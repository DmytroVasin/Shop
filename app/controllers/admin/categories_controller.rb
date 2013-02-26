class Admin::CategoriesController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @categories = Category.order('name')
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      flash[:notice] = 'Category created'
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    flash[:notice] = 'Category deleted'
    redirect_to admin_categories_path
  end
end
