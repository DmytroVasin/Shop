class OrderNotifier < ActionMailer::Base
  default from: 'from@example.com'

  helper :application

  def received(order)
    @order = order

    mail to: 'order.vako@gmail.com', subject: "Новый заказ! №#{@order.id}"
  end

  def shipped(order)
    @order = order
    @line_items = @order.line_items

    mail to: @order.email, subject: 'Ваш заказ на Vako.dn.ua'
  end

  def recall(info)
    @info = info

    mail to: 'order.vako@gmail.com', subject: 'Запрос на перезванивание'
  end
end
