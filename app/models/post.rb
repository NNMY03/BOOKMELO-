class Post < ApplicationRecord

#　楽天API中間テーブル
  belongs_to :customer
  belongs_to :book


  # タグ機能アソシエーション
  has_many :post_tags
  has_many :tags, through: :post_tags
  
  # 投稿制約
  validates :reading_finish, presence: true
  validates :tag_ids, presence: true





  # include ActiveModel::Model
  # attr_accessor :id, :category
  # ALL = %w[].map.with_index(1) {|category, index| new(id: index, category: category)}.freeze

end
