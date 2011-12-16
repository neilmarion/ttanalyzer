class CreateTts < ActiveRecord::Migration
  def change
    create_table :tts do |t|
      t.integer :position
      t.belongs_to :tt_term
      t.belongs_to :per_5_min

      t.timestamps
    end
    add_index :tts, :tt_term_id
    add_index :tts, :per_5_min_id
  end
end
