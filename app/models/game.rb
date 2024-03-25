class Game < ApplicationRecord
  has_one :chatroom
  has_one :board

  belongs_to :white, class_name: "User"
  belongs_to :black, class_name: "User", optional: true
end
