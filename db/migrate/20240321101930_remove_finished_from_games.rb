class RemoveFinishedFromGames < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :finished
  end
end
