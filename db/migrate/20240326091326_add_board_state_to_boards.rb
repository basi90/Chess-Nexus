class AddBoardStateToBoards < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :board_state, :jsonb, array: true, default: []
  end
end
