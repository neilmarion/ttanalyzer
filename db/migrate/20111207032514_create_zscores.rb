class CreateZscores < ActiveRecord::Migration
  def change
    create_table :zscores do |t|
      t.float :zscore
      t.belongs_to :per_min
      t.belongs_to :term

      t.timestamps
    end
    add_index :zscores, :per_min_id
    add_index :zscores, :term_id
  end
end
