class OrderNotifier < ActionMailer::Base
  default from: 'from@example.com'

  # includer ApplicationHelper
  helper :application

  def received(order)
    @order = order

    mail to: 'dracon779@gmail.com', subject: "Новый заказ! №#{@order.id}"
  end

  def shipped(order)

    @order = order
    @line_items = @order.line_items

    mail to: @order.email, subject: 'Ваш заказ на Vako.dn.ua'
  end
end
