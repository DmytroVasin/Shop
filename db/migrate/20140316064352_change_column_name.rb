class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :orders, :pay_type, :delivery
  end
end
