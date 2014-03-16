class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :surname
      t.string :phone
      t.string :additional_phone
      t.string :address
      t.string :region
      t.string :city
      t.string :email
      t.string :delivery
      t.text :info

      t.timestamps
    end
  end
end
