class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :company
      t.string :account_num
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.text :pickup_address
      t.string :pickup_city
      t.string :pickup_zip
      t.string :pickup_company
      t.string :pickup_contact
      t.string :pickup_phone
      t.text :delivery_address
      t.string :delivery_city
      t.string :delivery_zip
      t.string :delivery_company
      t.string :delivery_contact
      t.string :delivery_phone
      t.date :pickup_date
      t.time :pickup_time
      t.date :delivery_date
      t.time :delivery_time

      t.timestamps
    end
  end
end
