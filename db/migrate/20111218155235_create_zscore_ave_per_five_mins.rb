class CreateZscoreAvePerFiveMins < ActiveRecord::Migration
  def change
    create_table :zscore_ave_per_five_mins do |t|
      t.float :zscore_sum
      t.integer :min
      t.belongs_to :per_five_min
      t.belongs_to :term

      t.timestamps
    end
    add_index :zscore_ave_per_five_mins, :per_five_min_id
  end
end
