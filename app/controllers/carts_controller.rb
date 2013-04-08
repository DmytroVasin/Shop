class CartsController < ApplicationController
  def show
    session_id = session[:cart_id]

    if params[:id].to_i != session_id
      logger.error '----> Try access to invalid cart'
      redirect_to products_path, alert: 'Invalid cart'
    else
      @cart  = Cart.find(session_id)
      @items = @cart.line_items

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @cart }
      end
    end
  end

  def destroy
    @cart = current_cart
    @cart.destroy

    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Your cart is empty!' }
    end
  end
end
