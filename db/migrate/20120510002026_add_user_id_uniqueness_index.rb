class AddUserIdUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :user_id, :unique => true
  end

  def self.down
    remove_index :users, :user_id
  end
end
