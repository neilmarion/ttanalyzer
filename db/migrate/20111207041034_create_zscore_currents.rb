class CreateZscoreCurrents < ActiveRecord::Migration
  def change
    create_table :zscore_currents do |t|
      t.float :zscore
      t.belongs_to :term

      t.timestamps
    end
    add_index :zscore_currents, :term_id
  end
end
