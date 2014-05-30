class VotesController < ApplicationController
  before_filter :find_product

  def update
    session[@product.id] = true

    score = params[:score].to_i

    if score.between?(1, 5)
      @product.score += score
      @product.voters_count += 1
      @product.save

      flash.now[:notice] = 'Ваш голос принят!'
    else
      flash.now[:alert] = 'Голос не принят!'
    end
  end

  # Clearing of votes is not comlited!
  # def destroy
  #   @product.update_attributes({ voters_count: 0, score: 0 })

  #   flash[:notice] = "Очищено!"
  #   redirect_to product_path(product)
  # end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

end
