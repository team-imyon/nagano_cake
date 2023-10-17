class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :id
      t.integer :customer_id
      t.integer :payment_method
      t.integer :status
      t.integer :posttage
      t.integer :totle_payment
      t.string :name
      t.string :post_code
      t.string :address

      t.timestamps
    end
  end
end
