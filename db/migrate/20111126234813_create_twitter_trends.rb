class CreateTwitterTrends < ActiveRecord::Migration
  def change
    create_table :twitter_trends do |t|
      t.int :position
      t.belongs_to :twitter_trend_term

      t.timestamps
    end
    add_index :twitter_trends, :twitter_trend_term_id
  end
end
