class AddZipCodeToConditions < ActiveRecord::Migration[5.1]
  def change
    add_column :conditions, :zip_code, :string, index: true
  end
end
