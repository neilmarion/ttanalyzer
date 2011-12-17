class CreatePerMinNewTermTotals < ActiveRecord::Migration
  def change
    create_table :per_min_new_term_totals do |t|
      t.integer :total
      t.belongs_to :per_min

      t.timestamps
    end
    add_index :per_min_new_term_totals, :per_min_id
  end
end
