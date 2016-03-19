class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :code
      t.integer :airline_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :from_point
      t.string :to_destination
      t.integer :seats
      t.integer :available_seats
      t.integer :cost

      t.timestamps null: false
    end
  end
end
