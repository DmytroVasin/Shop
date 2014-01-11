class CreateColoursTable < ActiveRecord::Migration
  def change
    create_table :colours do |t|
      t.string :name
    end
  end
end
