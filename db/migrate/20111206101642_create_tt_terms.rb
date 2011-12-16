class CreateTtTerms < ActiveRecord::Migration
  def change
    create_table :tt_terms do |t|
      t.string :term

      t.timestamps
    end
  end
end
