class Favorite < ApplicationRecord
  
# お気に入り機能一覧
belongs_to :customer
belongs_to :post

end
