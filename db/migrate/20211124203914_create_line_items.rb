class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :quantity
      t.integer :amount

      t.timestamps
    end
  end
end
