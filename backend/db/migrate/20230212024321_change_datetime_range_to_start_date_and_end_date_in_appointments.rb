class ChangeDatetimeRangeToStartDateAndEndDateInAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :datetime_range
    add_column :appointments, :start_date, :datetime
    add_column :appointments, :end_date, :datetime
  end
end
