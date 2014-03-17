class AddPaymentMethodToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_method, :string, default: 'Полная (100%)'
  end
end
