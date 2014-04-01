class Admin::ColoursController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @colours = Colour.order('name').page(params[:page]).per(10)
  end

  def new
    @colour = Colour.new
  end

  def edit
    @colour = Colour.find(params[:id])
  end

  def create
    @colour = Colour.new(params[:colour])

    if @colour.save
      redirect_to admin_colours_path, notice: 'Color created'
    else
      render 'new'
    end
  end

  def update
    @colour = Colour.find(params[:id])
    @colour.update_attributes(params[:colour])

    flash[:notice] = 'Success updated this order note'
    redirect_to admin_colours_path
  end

  def update_common_colour
    @colours = Colour.order('name').page(params[:page]).per(10)

    colour = Colour.find(params[:id])
    acceptedColorArray = params[:acceptedColorArray]

    common_colors = Hash[acceptedColorArray.map { |x| [x, x] }]

    colour.update_attributes({common_colors: common_colors})


    flash[:notice] = 'Общий цвет - обновлен!'
    flash.keep(:notice) # Keep flash notice around for the redirect.

    render js: "window.location = '/admin/colours'"
  end

  # def destroy
  #   @colour = Colour.find(params[:id])
  #   @colour.destroy

  #   redirect_to admin_colours_path, notice: 'Color deleted'
  # end
end
