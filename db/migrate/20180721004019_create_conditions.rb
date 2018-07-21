class CreateConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :conditions do |t|
      t.date :date
      t.integer :max_temp
      t.integer :mean_temp
      t.integer :min_temp
      t.integer :mean_humidity
      t.integer :mean_visibility
      t.integer :mean_wind_speed
      t.float :precipitation

      t.timestamps
    end
  end
end
