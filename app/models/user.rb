class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :prototypes
  has_many :likes, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, uniqueness: true
end
