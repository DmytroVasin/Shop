class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :small
      t.text :middle
      t.text :large
    end
  end
end
