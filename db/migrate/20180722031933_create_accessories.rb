class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :image_url
      t.string :title
      t.string :description
      t.float :price
      t.integer :status
    end
  end
end
