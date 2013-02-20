class Admin::PerfumesController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @perfumes = Perfume.all
  end

  def show
    @perfume = Perfume.find(params[:id])
  end

  def new
     @perfume = Perfume.new
  end

  def edit
    @perfume = Perfume.find(params[:id])
  end
end
