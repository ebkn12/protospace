class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images
  accepts_nested_attributes_for :captured_images, allow_destroy: true
end
