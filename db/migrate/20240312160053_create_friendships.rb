class CreateFriendships < ActiveRecord::Migration[7.1]
  def change
    create_table :friendships do |t|
      t.references :asker_id, null: false, foreign_key: { to_table: :users }
      t.references :receiver_id, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
