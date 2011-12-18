class CreatePerFiveMins < ActiveRecord::Migration
  def change
    create_table :per_five_mins do |t|
      t.belongs_to :per_hour


      t.timestamps
    end
  end
end
