class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id,null: false
      t.integer :payment_method,null: false, default: 0
      t.integer :status,null: false, default: 0
      t.integer :posttage,null: false
      t.integer :totle_payment,null: false
      t.string :name,null: false
      t.string :post_code,null: false
      t.string :address,null: false

      t.timestamps
    end
  end
end
