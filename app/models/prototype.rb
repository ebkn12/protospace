class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images, dependent: :destroy
  accepts_nested_attributes_for :captured_images, allow_destroy: true
  validates :title, :user_id, presence: true

  def main_image
    captured_images.find_by(status: 1)
  end

  def sub_images
    captured_images.where(status: 0)
  end
end
