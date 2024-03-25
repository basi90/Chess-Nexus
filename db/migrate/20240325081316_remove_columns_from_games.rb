class RemoveColumnsFromGames < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :board_state
    remove_column :games, :moves
    remove_column :games, :next_to_move
  end
end
