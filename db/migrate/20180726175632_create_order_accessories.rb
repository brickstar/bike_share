class CreateOrderAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :order_accessories do |t|
      t.integer :quantity
      t.references :order, foreign_key: true
      t.references :accessory, foreign_key: true

      t.timestamps
    end
  end
end
