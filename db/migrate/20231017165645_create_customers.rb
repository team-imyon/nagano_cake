class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.integer :id
      t.boolean :is_ative
      t.string :last_name
      t.string :first_name
      t.string :furigana_last_name
      t.string :furigana_first_name
      t.string :email
      t.string :post_code
      t.string :address
      t.string :tel_number
      t.string :encrypted_password
      t.datetime :created_at
      t.datetime :update_at

      t.timestamps
    end
  end
end
