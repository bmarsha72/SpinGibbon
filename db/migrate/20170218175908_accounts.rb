class Accounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |table|
      table.string :first_name
      table.string :last_name
      table.string :email
      table.string :password_hash
      table.string :password_salt
      table.string :liberal
      table.string :moderate
      table.string :conservative
  end
  end
end
