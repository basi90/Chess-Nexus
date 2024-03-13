class Board < ApplicationRecord
  belongs_to :white_id, class_name: "User", optional: true
  belongs_to :black_id, class_name: "User", optional: true
  belongs_to :winner, class_name: "User", optional: true

  def winning_user
    winner if finished && winner.present?
  end
end
