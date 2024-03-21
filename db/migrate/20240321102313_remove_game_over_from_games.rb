class RemoveGameOverFromGames < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :game_over
  end
end
