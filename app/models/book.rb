class Book < ApplicationRecord
  
  # 楽天API
    self.primary_key = "isbn"
  has_many :posts, dependent: :destroy
  
end
