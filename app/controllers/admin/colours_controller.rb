class Admin::ColoursController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @colours = Colour.order('name').page(params[:page]).per(10)
  end

  def new
    @colours = Colour.new
  end

  def create
    @colours = Colour.new(params[:colours])

    if @colours.save
      redirect_to admin_colours_path, notice: 'Color created'
    else
      render 'new'
    end
  end
end
