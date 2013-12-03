class CreateReviewTable < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :full_name
      t.string :address
      t.integer :url_id
      t.text :delivery_time
      t.text :quality
      t.text :suggestions

      t.timestamps
    end
  end
end
