class CreatePerMinStreamTermTotals < ActiveRecord::Migration
  def change
    create_table :per_min_stream_term_totals do |t|
      t.int :total
      t.belongs_to :per_min

      t.timestamps
    end
    add_index :per_min_stream_term_totals, :per_min_id
  end
end
