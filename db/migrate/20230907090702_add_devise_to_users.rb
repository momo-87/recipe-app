# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def self.up
    change_table :users, bulk: true do |t|
      ## Database authenticatable
      t.string :email, null: false, default: "" unless column_exists?(:users, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:users, :encrypted_password)

      ## Recoverable
      t.string :reset_password_token unless column_exists?(:users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:users, :reset_password_sent_at)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)

      ## Confirmable
      t.string :confirmation_token unless column_exists?(:users, :confirmation_token)
      t.datetime :confirmed_at unless column_exists?(:users, :confirmed_at)
      t.datetime :confirmation_sent_at unless column_exists?(:users, :confirmation_sent_at)
      t.string :unconfirmed_email unless column_exists?(:users, :unconfirmed_email)

      ## Lockable (commented out by default)
      # t.integer  :failed_attempts, default: 0, null: false unless column_exists?(:users, :failed_attempts)
      # t.string   :unlock_token unless column_exists?(:users, :unlock_token)
      # t.datetime :locked_at unless column_exists?(:users, :locked_at)
    end

    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
    # add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
    # add_index :users, :unlock_token, unique: true unless index_exists?(:users, :unlock_token)
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
