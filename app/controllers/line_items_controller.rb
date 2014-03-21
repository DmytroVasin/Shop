class LineItemsController < ApplicationController
  def create
    param      = params[:line_item]
    # param[:color] => "Black"
    @cart      = current_cart
    product    = Product.find(param[:current_product])
    @line_item = @cart.add_product(product, @cart.id, param[:color])

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @cart      = current_cart
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      if current_cart.line_items.empty?
        @cart.destroy
        session[:cart_id] = nil
        format.html { redirect_to(products_path, notice: 'Ваша корзина пуста!') }
      else
        format.html { redirect_to(@line_item.cart, notice: 'Товар был убран из корзины.') }
      end
    end
  end

  def decrease
    @cart      = current_cart
    @line_item = @cart.decrease(params[:id])
    @items     = @cart.line_items

    respond_to do |format|
      if @items.empty?
        @cart.destroy
        session[:cart_id] = nil
        format.html { redirect_to products_path, notice: 'Empty cart' }
      elsif @line_item.save
        rendering(format)
      end
    end
  end

  def increase
    @cart      = current_cart
    @line_item = @cart.increase(params[:id])
    @items     = @cart.line_items.order('created_at ASC')
    respond_to do |format|
      if @line_item.save
        rendering(format)
      end
    end
  end

  private

  def rendering(format)
    format.html { redirect_to @line_item.cart, notice: 'Item was successfully removed' }
    format.js { @current_item = @line_item, @items }
  end
end
