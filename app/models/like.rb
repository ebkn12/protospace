class Like < ApplicationRecord
  belongs_to :user
  belongs_to :prototype

  validates :user_id, :prototype_id, presence: true
end
