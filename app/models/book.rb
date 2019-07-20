class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  belongs_to :user
  has_many :book_favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited?(user_id)
    self.book_favorites.where(user_id: user_id).exists?
  end
end
