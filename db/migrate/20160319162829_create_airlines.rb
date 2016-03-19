class CreateAirlines < ActiveRecord::Migration
  def change
    create_table :airlines do |t|
      t.string :code
      t.string :name
      t.string :website

      t.timestamps null: false
    end
  end
end
