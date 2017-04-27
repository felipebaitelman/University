class CreateBookedHours < ActiveRecord::Migration[5.0]
  def change
    create_table :booked_hours do |t|
      t.integer :id_event_date
      t.integer :id_user

      t.timestamps
    end
  end
end
