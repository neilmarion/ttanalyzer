class CreatePerQuarts < ActiveRecord::Migration
  def change
    create_table :per_quarts do |t|

      t.timestamps
    end
  end
end
