class Chatroom < ApplicationRecord
  belongs_to :game
  has_many :messages
end
