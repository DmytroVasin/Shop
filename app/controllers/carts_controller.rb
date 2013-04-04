class CartsController < ApplicationController
  def show
    begin
      session_id = session[:cart_id]
      @cart      = Cart.find(session_id)
      @items     = @cart.line_items

      raise ActiveRecord::RecordNotFound unless params[:id].to_i == session_id

    rescue ActiveRecord::RecordNotFound
      logger.error '----> Try access to invalid cart'
      redirect_to products_path, alert: 'Invalid cart'
    else
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
