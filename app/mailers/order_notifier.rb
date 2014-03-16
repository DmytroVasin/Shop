class OrderNotifier < ActionMailer::Base
  default from: 'from@example.com'

  # includer ApplicationHelper
  helper :application

  def received(order)
    @order = order

    mail to: 'dracon779@gmail.com', subject: 'Got new order!'
  end

  def shipped(order)

    @order = order
    @line_items = @order.line_items

    mail to: @order.email, subject: 'You orderd in our shop:'
  end
end
