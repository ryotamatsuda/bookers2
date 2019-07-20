class User < ApplicationRecord

  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  has_many :books, class_name: "Book", foreign_key: "user_id", dependent: :destroy
  has_many :book_favorites, class_name: "BookFavorite", foreign_key: "book_id",  dependent: :destroy
  has_many :book_comments, class_name: "BookComment", foreign_key: "book_id", dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: "follower"
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: "following"

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end
