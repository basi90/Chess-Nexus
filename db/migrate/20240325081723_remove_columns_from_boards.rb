class RemoveColumnsFromBoards < ActiveRecord::Migration[7.1]
  def change
    remove_column :boards, :finished
    remove_column :boards, :white_id_id
    remove_column :boards, :black_id_id
    remove_column :boards, :winner_id
  end
end
