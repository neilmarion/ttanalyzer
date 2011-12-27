class CreateZscoreSumPerFiveMins < ActiveRecord::Migration
  def change
    create_table :zscore_sum_per_five_mins do |t|
      t.float :zscore_sum
      t.belongs_to :term

      t.timestamps
    end
    add_index :zscore_sum_per_five_mins, :term_id
  end
end
