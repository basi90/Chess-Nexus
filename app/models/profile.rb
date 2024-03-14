class Profile < ApplicationRecord
  has_one_attached :profile_picture
  belongs_to :user
  has_many :sent_friendships, class_name: "Friendship", foreign_key: "asker_id", dependent: :destroy
  has_many :received_friendships, class_name: "Friendship", foreign_key: "receiver_id", dependent: :destroy
end
