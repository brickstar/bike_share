class ChangePriceInAccessories < ActiveRecord::Migration[5.1]
  def change
    change_column :accessories, :price, :integer
  end
end
