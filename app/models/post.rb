class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :book

  # お気に入り機能アソシエーション
  has_many :favorites, dependent: :destroy

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  include ActiveModel::Model
  attr_accessor :id, :category
  ALL = %w[].map.with_index(1) {|category, index| new(id: index, category: category)}.freeze

end
