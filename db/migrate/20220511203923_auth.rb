class Auth < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :auth_users, id: :uuid do |t|
      t.string :email
      t.string :password
      t.string :role, default: 'event_assistant'
      t.timestamps
    end

    add_column :auth_users, :password_digest, :string

    create_table :users, id: :uuid do |t|
      t.references :auth_user, index: true, type: :uuid, foreign_key: {to_table: :auth_users, on_delete: :cascade}
      t.string :full_name
      t.string :status
      t.timestamps
    end

    create_table :events, id: :uuid do |t|
      t.string :name
      t.date :event_date
      t.timestamps
    end

    create_table :assistances, id: :uuid do |t|
      t.references :event, index: true, type: :uuid, foreign_key: {to_table: :events, on_delete: :cascade}
      t.references :user, index: true, type: :uuid, foreign_key: {to_table: :users, on_delete: :cascade}
      t.timestamps
    end
  end
end
