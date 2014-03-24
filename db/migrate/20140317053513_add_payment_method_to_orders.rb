class AddPaymentMethodToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_method, :string, default: '0.1'
  end
end
