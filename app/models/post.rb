class Post < ApplicationRecord

#　楽天API中間テーブル
  belongs_to :customer
  belongs_to :book


  # タグ機能アソシエーション
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags




  # include ActiveModel::Model
  # attr_accessor :id, :category
  # ALL = %w[].map.with_index(1) {|category, index| new(id: index, category: category)}.freeze

end
