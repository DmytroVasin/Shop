class Admin::CategoriesController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @categories = Categries.all
  end
end
