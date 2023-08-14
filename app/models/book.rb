class Book < ApplicationRecord
  
  # 楽天API
    # self.primary_key = "isbn"
  has_many :posts
  has_many :customers, through: :posts
  
  # お気に入り機能アソシエーション
  has_many :favorites, dependent: :destroy

  # def favorited_by?(customer)
  #   favorites.exists?(customer_id: customer.id)
  # end

  
end
