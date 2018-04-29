class CapturedImage < ApplicationRecord
  belongs_to :prototype

  mount_uploader :content, ContentUploader

  validates :content, :status, presence: true
end
