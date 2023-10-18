class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.boolean :is_ative,null: false, default: true
      t.string :last_name,null: false
      t.string :first_name,null: false
      t.string :furigana_last_name,null: false
      t.string :furigana_first_name,null: false
      t.string :email,null: false
      t.string :post_code,null: false
      t.string :address,null: false
      t.string :tel_number,null: false
      t.string :encrypted_password,null: false


      t.timestamps
    end
  end
end