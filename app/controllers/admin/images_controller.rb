class Admin::ImagesController < Admin::BaseController
	def destroy
    @image = Image.find(params[:id])
    product = @image.products.first
    @image.destroy
    @images = product.images

    respond_to do |format|
      format.html { redirect_to admin_root_path, notice: 'Brand deleted' }
      format.js
    end
	end
end