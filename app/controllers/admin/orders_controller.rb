class Admin::OrdersController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    #@orders = Order.joins(:line_items).where('line_items.cart_id IS NOT NULL')
    @orders = Order.includes(:line_items)
  end

  def show
    @order = Order.find(params[:id])
  end
end
