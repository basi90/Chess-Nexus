class DeleteForeignKeysFromFriendships < ActiveRecord::Migration[7.1]
  def change
    remove_column :friendships, :asker_id_id
    remove_column :friendships, :receiver_id_id
  end
end
