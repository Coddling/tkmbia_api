class AddStatusToAuthUser < ActiveRecord::Migration[6.1]
  def change
    add_column :auth_users, :status, :string, default: 'active'
  end
end
