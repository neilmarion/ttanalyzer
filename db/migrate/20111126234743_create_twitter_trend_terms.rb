class CreateTwitterTrendTerms < ActiveRecord::Migration
  def change
    create_table :twitter_trend_terms do |t|
      t.string :term

      t.timestamps
    end
  end
end
