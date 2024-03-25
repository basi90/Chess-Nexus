class ChangeColumnTypeInBoards < ActiveRecord::Migration[7.1]
  def change
    change_column :boards, :board_state, :jsonb, using: 'board_state::jsonb'
  end
end
