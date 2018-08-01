class AddConditionToTrips < ActiveRecord::Migration[5.1]
  def change
    add_reference :trips, :condition, foreign_key: true
  end
end
