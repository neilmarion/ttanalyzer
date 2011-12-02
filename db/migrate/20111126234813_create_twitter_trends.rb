class CreateTwitterTrends < ActiveRecord::Migration
  def change
    create_table :twitter_trends do |t|
      t.integer :position
      t.belongs_to :twitter_trend_term
      t.belongs_to :per_quart

      t.timestamps
    end
    add_index :twitter_trends, :twitter_trend_term_id
  end
end
