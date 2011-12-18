class CreateZscoreAvePerHours < ActiveRecord::Migration
  def change
    create_table :zscore_ave_per_hours do |t|
      t.float :zscore_sum
      t.integer :min
      t.belongs_to :per_hour
      t.belongs_to :term

      t.timestamps
    end
    add_index :zscore_ave_per_hours, :per_hour_id
  end
end
