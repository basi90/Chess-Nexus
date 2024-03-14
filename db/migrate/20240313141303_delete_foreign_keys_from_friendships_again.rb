class DeleteForeignKeysFromFriendshipsAgain < ActiveRecord::Migration[7.1]
  def change
    remove_column :friendships, :asker_id
    remove_column :friendships, :receiver_id
  end
end
