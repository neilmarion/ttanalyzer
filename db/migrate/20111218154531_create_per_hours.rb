class CreatePerHours < ActiveRecord::Migration
  def change
    create_table :per_hours do |t|

      t.timestamps
    end
  end
end
