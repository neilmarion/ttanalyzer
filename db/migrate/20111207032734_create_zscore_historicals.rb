class CreateZscoreHistoricals < ActiveRecord::Migration
  def change
    create_table :zscore_historicals do |t|
      t.integer :n
      t.integer :sum
      t.float :sqr_total
      t.integer :first_min
      t.integer :last_min
      t.belongs_to :term

      t.timestamps
    end
    add_index :zscore_historicals, :term_id
  end
end
