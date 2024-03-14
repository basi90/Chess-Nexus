class Friendship < ApplicationRecord
  belongs_to :asker, class_name: "Profile"
  belongs_to :receiver, class_name: "Profile"

  validates_uniqueness_of :asker_id, scope: [:receiver_id]
end
