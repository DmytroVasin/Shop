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
      redirect_to admin_categories_path, notice: 'Category created'
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])

    redirect_to admin_categories_path
  end

  # def destroy
  #   @category = Category.find(params[:id])
  #   @category.destroy

  #   redirect_to admin_categories_path, notice: 'Category deleted'
  # end
end
