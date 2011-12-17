class CreateTtScores < ActiveRecord::Migration
  def change
    create_table :tt_scores do |t|
      t.integer :score
      t.integer :minutes
      t.belongs_to :tt_term

      t.timestamps
    end
    add_index :tt_scores, :tt_term_id
  end
end
