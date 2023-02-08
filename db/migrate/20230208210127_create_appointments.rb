class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :title
      t.text :description
      t.tstzrange :datetime_range

      t.timestamps
    end
  end
end
