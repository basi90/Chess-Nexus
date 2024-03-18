class ChangeChatroomsReferences < ActiveRecord::Migration[7.1]
  def change
    remove_reference :chatrooms, :board, foreign_key: true
    add_reference :chatrooms, :game, foreign_key: true
  end
end
