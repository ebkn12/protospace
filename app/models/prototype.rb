class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images, dependent: :destroy
  accepts_nested_attributes_for :captured_images, allow_destroy: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  acts_as_taggable

  validates :title, :user_id, presence: true

  paginates_per 20

  scope :order_by_newest, lambda { |page|
    includes(
      :user,
      :captured_images,
      :tag_taggings,
      :tags
    )
      .order('created_at desc')
      .page(page)
  }

  scope :order_by_popular, lambda { |page|
    includes(
      :user,
      :captured_images,
      :tag_taggings,
      :tags
    )
      .joins(:likes)
      .order('likes_count desc')
      .order('created_at desc')
      .page(page)
  }

  scope :related_tag, lambda { |tag_name, page|
    tagged_with(tag_name)
      .includes(
        :user,
        :captured_images,
        :tag_taggings,
        :tags
      )
      .order('created_at desc')
      .page(page)
  }

  def related_comments(page)
    comments
      .includes(:user)
      .page(page)
      .order('created_at desc')
  end

  def main_image
    captured_images.find_by(status: 1)
  end

  def sub_images
    captured_images.where(status: 0)
  end
end
