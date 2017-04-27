class AddRemainingCapacityToEventDates < ActiveRecord::Migration[5.0]
  def change
    add_column :event_dates, :remaining_capacity, :integer

  end
end
