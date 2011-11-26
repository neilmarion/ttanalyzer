class CreatePerMins < ActiveRecord::Migration
  def change
    create_table :per_mins do |t|

      t.timestamps
    end
  end
end
