class Post < ApplicationRecord
  
  belongs_to :customers

  
# お気に入り機能アソシエーション
  has_many :favorites, dependent: :destroy

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  
end
