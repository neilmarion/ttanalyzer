class CreatePerMinStreamTweetTotals < ActiveRecord::Migration
  def change
    create_table :per_min_stream_tweet_totals do |t|
      t.integer :total
      t.belongs_to :per_min

      t.timestamps
    end
    add_index :per_min_stream_tweet_totals, :per_min_id
  end
end
