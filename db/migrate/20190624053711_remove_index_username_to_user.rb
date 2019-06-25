class RemoveIndexUsernameToUser < ActiveRecord::Migration[5.2]
  def down
    remove_index :users, column: :username, unique: true
  end
end
