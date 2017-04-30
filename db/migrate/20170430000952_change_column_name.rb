class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :company, :company_name
    rename_column :orders, :email, :company_email
  end
end
