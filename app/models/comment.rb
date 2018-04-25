class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype

  validates :content, presence: true

  paginates_per 10
end
