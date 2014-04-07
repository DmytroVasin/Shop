class Admin::ColoursController < Admin::BaseController
  before_filter :authenticate_admin!
  before_filter :find_colour, only: [:edit, :update, :update_common_colour]

  def index
    @colours = Colour.order('id DESC').page(params[:page]).per(10)
    @materials = @colour.materials
    @zippers = @colour.zippers
    @features = @colour.features
  end

  def new
    @colour = Colour.new
  end

  def edit
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
    @colour.update_attributes(params[:colour])

    flash[:notice] = 'Success updated this order note'
    redirect_to admin_colours_path
  end

  def update_common_colour
    @colours = Colour.order('name').page(params[:page]).per(10)

    acceptedColorArray, acceptedMaterialArray, acceptedZipperArray, acceptedFeatureArray  = params[:acceptedColorArray], params[:acceptedMaterialArray], params[:acceptedZipperArray], params[:acceptedFeatureArray]

    common_colors = Colour.create_hash_by( Colour::COMMON_COLORS_RUS, acceptedColorArray)
    materials = Colour.create_hash_by( Colour::MATERIAL, acceptedMaterialArray)
    zippers = Colour.create_hash_by( Colour::CLOSING_TYPE, acceptedZipperArray)
    features = Colour.create_hash_by( Colour::FEATURES, acceptedFeatureArray)

    @colour.update_attributes({ common_colors: common_colors, zippers: zippers, materials: materials, features: features })

    flash[:notice] = 'Общий цвет - обновлен!'
    render js: 'window.location.reload()'
  end

  # def destroy
  #   @colour = Colour.find(params[:id])
  #   @colour.destroy

  #   redirect_to admin_colours_path, notice: 'Color deleted'
  # end

  private

  def find_colour
    @colour = Colour.find(params[:id])
  end
end
