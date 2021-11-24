class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :subtotal
      t.float :tax
      t.float :total

      t.timestamps
    end
  end
end
