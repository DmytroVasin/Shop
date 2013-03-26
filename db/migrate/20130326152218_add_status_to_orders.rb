# encoding: utf-8
class AddStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :status, :string, default: 'Заказано'
    add_column :orders, :adm_info, :text
  end
end
