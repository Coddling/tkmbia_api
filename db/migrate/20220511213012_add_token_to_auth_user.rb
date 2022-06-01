class AddTokenToAuthUser < ActiveRecord::Migration[6.1]
  def change
    add_column :auth_users, :token, :string
  end
end
