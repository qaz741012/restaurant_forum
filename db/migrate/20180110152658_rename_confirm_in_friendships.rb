class RenameConfirmInFriendships < ActiveRecord::Migration[5.1]
  def change
    remove_column :friendships, :confirm?
    add_column :friendships, :status, :string
  end
end
