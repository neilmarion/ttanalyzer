class CreateZscoreTrendsPerFiveMinReports < ActiveRecord::Migration
  def change
    create_table :zscore_trends_per_five_min_reports do |t|
      t.float :zscore_ave
      t.belongs_to :term
      t.belongs_to :per_five_min

      t.timestamps
    end
    add_index :zscore_trends_per_five_min_reports, :term_id
    add_index :zscore_trends_per_five_min_reports, :per_five_min_id
  end
end
