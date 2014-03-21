class OrdersController < ApplicationController
  def new
    @cart = current_cart
    @line_items = @cart.line_items

    if @cart.line_items.empty?
      redirect_to products_path, alert: 'Невозможно создать Заказ без товаров...'
      return
    end

    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def create
    @order = Order.new(params[:order])
    @order.input_line_items_to_order(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        # email send to admin verification letter
        OrderNotifier.received(@order).deliver
        # email send to user witch create order
        OrderNotifier.shipped(@order).deliver

        format.html { redirect_to root_path, notice: 'Ваш заказ принят!' }
			else
        @cart = current_cart
        @line_items = @cart.line_items

        format.html { render action: 'new' }
      end
    end
  end
end
