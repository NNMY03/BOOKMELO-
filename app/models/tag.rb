class Tag < ApplicationRecord
  
  # タグの一意性の保持
  validates :name, uniqueness: true

  has_many :post_tags
  has_many :posts, through: :post_tags

end
