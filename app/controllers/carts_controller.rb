class CartsController < ApplicationController
  def show
    session_id = session[:cart_id]

    if params[:id].to_i != session_id
      logger.error '----> Try access to invalid cart'
      redirect_to products_path, alert: 'Ваша корзина пуста!'
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
      format.html { redirect_to products_path, notice: 'Ваша корзина пуста!' }
    end
  end
end
