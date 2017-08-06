class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype

  validates :content, :user_id, :prototype_id, presence: true

  paginates_per 10
end
