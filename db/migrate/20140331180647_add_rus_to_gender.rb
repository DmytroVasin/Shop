class AddRusToGender < ActiveRecord::Migration
  def change
    add_column :genders, :gender_rus, :string
  end
end
