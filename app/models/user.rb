class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :prototypes
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, uniqueness: true

  def related_prototypes(page)
    prototypes
      .includes(
        :captured_images,
        :tag_taggings,
        :tags
      )
      .order('created_at desc')
      .page(page)
  end
end
