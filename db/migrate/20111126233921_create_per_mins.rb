class CreatePerMins < ActiveRecord::Migration
  def change
    create_table :per_mins do |t|
      t.belongs_to :per_hour
      t.belongs_to :per_five_min

      t.timestamps
    end
  end
end
