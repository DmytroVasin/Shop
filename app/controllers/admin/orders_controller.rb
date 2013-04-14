class Admin::OrdersController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    #@orders = Order.joins(:line_items).where('line_items.cart_id IS NOT NULL')
    @orders = Order.includes(:line_items)
    @orders = @orders.order(params[:sort] + ' ' + params[:direction]) if params[:sort]
    @orders = @orders.order('updated_at ASC') unless params[:sort]
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
