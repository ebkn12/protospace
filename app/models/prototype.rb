class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images
end
