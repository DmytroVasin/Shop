class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart      = current_cart
    product    = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @cart = current_cart

    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      if current_cart.line_items.empty?
        session[:cart_id] = nil
        format.html { redirect_to(products_path, notice: 'Your cart is empty') }
      else
        format.html { redirect_to(@line_item.cart, notice: 'Item has been removed from your cart.') }
      end
    end
  end


  def decrease
    @cart      = current_cart
    @line_item = @cart.decrease(params[:id])

    @items = @cart.line_items

    respond_to do |format|
      if @items.empty?

        @cart.destroy
        session[:cart_id] = nil

        format.html { redirect_to products_path, notice: 'Empty cart' }
      else
        if @line_item.save
          format.html { redirect_to @line_item.cart, notice: 'Line item was successfully updated.' }
          format.js { @current_item = @line_item, @items }
        else
          format.html { render action: "edit" }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def increase
    @cart      = current_cart
    @line_item = @cart.increase(params[:id])

    @items = @cart.line_items

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'Line item was successfully updated.' }
        format.js { @current_item = @line_item, @items }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end
end
