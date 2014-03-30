class OptionalPagesController < ApplicationController
  def contacts_call
    info = params[:call]
    OrderNotifier.recall(info).deliver
  end
end
