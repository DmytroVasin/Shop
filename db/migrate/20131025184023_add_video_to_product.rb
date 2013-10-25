class AddVideoToProduct < ActiveRecord::Migration
  def change
    add_column :products, :video_href, :text
  end
end
