class AddGamesToBoards < ActiveRecord::Migration[7.1]
  def change
    add_reference :boards, :game, null: false, foreign_key: true
  end
end
