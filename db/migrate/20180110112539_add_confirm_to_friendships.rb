class AddConfirmToFriendships < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :confirm?, :boolean
  end
end
