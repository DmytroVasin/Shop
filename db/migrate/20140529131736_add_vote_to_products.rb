class AddVoteToProducts < ActiveRecord::Migration
  def up
    update_score_and_voters_sql = <<-SQL
      UPDATE products
      SET voters_count = 0, score = 0
    SQL


    add_column :products, :voters_count, :integer, default: 0
    add_column :products, :score, :integer, default: 0

    execute update_score_and_voters_sql
  end

  def down
    remove_column :products, :voters_count
    remove_column :products, :score
  end
end
