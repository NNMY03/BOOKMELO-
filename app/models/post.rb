class Post < ApplicationRecord

# 楽天API中間テーブル
  belongs_to :customer
  belongs_to :book

# タグ機能アソシエーション
  has_many :post_tags
  has_many :tags, through: :post_tags

# 通報機能
  has_many :report
  has_many :customers, through: :report

# 投稿制約
  validates :reading_finish, presence: true
  validates :tag_ids, presence: true

# 公開機能
  scope :posted_status, -> {where(posted_status: false)}
  scope :unposted_status, -> {where(posted_status: true)}

# 通報機能
  has_many :report
  has_many :customers, through: :report

  # 投稿数表示
  scope :today_count, -> {where(created_at: Time.zone.now.all_day)}
  scope :agoday_count, -> {where(created_at: 1.day.ago.all_day)}
  scope :toweek_count, -> {where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :agoweek_count, -> {where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }

  # include ActiveModel::Model
  # attr_accessor :id, :category
  # ALL = %w[].map.with_index(1) {|category, index| new(id: index, category: category)}.freeze
  def self.count_posts_with_tag(posts, tag_name)
    count = 0
    ## 第一引数にある、postsを全てループする
    for post in posts do
      ## postの中にある、タグネームを検索して一致したものをカウントする、
      for tag in post.tags do
        if tag.name == tag_name
          count += 1
        end
      end
    end
    return count
  end
end
