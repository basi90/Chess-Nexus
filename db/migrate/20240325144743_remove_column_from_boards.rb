class RemoveColumnFromBoards < ActiveRecord::Migration[7.1]
  def change
    remove_column :boards, :board_state, :jsonb
  end
end
