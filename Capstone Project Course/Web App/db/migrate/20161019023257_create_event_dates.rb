class CreateEventDates < ActiveRecord::Migration[5.0]
  def change
    create_table :event_dates do |t|
      t.integer :event_id
      t.timestamp :start_date
      t.timestamp :end_date
      t.integer :host_id
      t.string :location
      t.integer :capacity

      t.timestamps
    end
  end
end
