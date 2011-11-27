class CreateFrequentPerMinTerms < ActiveRecord::Migration
  def change
    create_table :frequent_per_min_terms do |t|
      t.integer :frequency
      t.belongs_to :term
      t.belongs_to :per_min

      t.timestamps
    end
    add_index :frequent_per_min_terms, :term_id
    add_index :frequent_per_min_terms, :per_min_id
  end
end
