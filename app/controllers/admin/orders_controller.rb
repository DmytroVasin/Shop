class Admin::OrdersController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @orders = Order.includes(:line_items)
    @orders = @orders.order(sort_column('Order') + ' ' + sort_direction).page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes!(params[:order])

    flash[:notice] = 'Success updated this order note'
    redirect_to admin_order_path(@order.id)
  end
end
