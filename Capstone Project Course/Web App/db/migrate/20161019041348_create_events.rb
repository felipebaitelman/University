class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :event_type_id
      t.integer :host_id
      t.integer :faculty_id
      t.string :location
      t.integer :capacity
      t.integer :created_by
      t.timestamp :start_hour
      t.timestamp :end_hour
      t.integer :day_id

      t.timestamps
    end
  end
end
