class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :point
      t.string :ip

      t.timestamps
    end
  end
end
