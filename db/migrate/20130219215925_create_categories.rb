class CreateCategories < ActiveRecord::Migration
  #require Rails.root.join('db/seeds/categories')

  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
  end
  #Seeds.create_categories
end
