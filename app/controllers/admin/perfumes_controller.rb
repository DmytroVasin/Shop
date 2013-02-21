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

  def create
    @perfume = Perfume.new(params[:perfume])

    if @perfume.save
      flash[:notice] = "Pefume created!"
      redirect_to admin_perfume_path(@perfume.id)
    else
      render 'new'
    end
  end

  def edit
    @perfume = Perfume.find(params[:id])
  end

  def update
    @perfume = Perfume.find(params[:id])

     if @perfume.update_attributes(params[:perfume])
      flash[:notice] = "Perfume updated"
      redirect_to admin_perfume_path(@perfume.id)
     else
      render 'edit'
     end
  end

  def destroy
    @perfume = Perfume.find(params[:id])

    @perfume.destroy
    redirect_to admin_perfumes_path
  end
end
