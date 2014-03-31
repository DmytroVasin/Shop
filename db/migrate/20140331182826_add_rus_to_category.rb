class AddRusToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :category_rus, :string
  end
end
