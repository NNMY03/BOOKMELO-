class Book < ApplicationRecord

  # 楽天API
    # self.primary_key = "isbn"
  has_many :posts
  has_many :customers, through: :posts

  # お気に入り機能アソシエーション
  has_many :favorites, dependent: :destroy

# 通報機能
  has_many :report
  has_many :customers, through: :report
  
  # タグ機能アソシエーション
  has_many :post_tags
  has_many :tags, through: :post_tags


  def favorites?(post)
    favorites.exists?(post_id: post.id)
  end
  
end
