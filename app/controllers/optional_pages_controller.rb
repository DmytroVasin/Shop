class OptionalPagesController < ApplicationController
  def contacts_call
    info = params[:call]
    OrderNotifier.delay.recall(info)
  end
end
