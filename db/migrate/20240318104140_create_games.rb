class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.text :board_state
      t.boolean :finished, default: false
      t.references :white, foreign_key: { to_table: :users }
      t.references :black, foreign_key: { to_table: :users }
      t.string :next_to_move
      t.text :moves
      t.references :winner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
