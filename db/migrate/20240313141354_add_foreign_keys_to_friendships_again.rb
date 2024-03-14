class AddForeignKeysToFriendshipsAgain < ActiveRecord::Migration[7.1]
  def change
    add_reference :friendships, :asker, null: false, foreign_key: { to_table: :profiles }
    add_reference :friendships, :receiver, null: false, foreign_key: { to_table: :profiles }
  end
end
