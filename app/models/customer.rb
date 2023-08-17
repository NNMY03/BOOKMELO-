class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
# 楽天API中間テーブル 
 has_many :posts, dependent: :destroy
 has_many :books, through: :posts
 
# お気に入り機能アソシエーション
 has_many :favorites, dependent: :destroy
 
# 通報機能
  has_many :report
  has_many :posts, through: :report

# customer　image画面
 has_one_attached :image
 
 # 退会済みユーザーをはじく 
 def active_for_authentication?
  super && (self.is_deleted == false)
 end
  
  def get_profile_image(height, width)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end
 
   def favorites?(post)
    favorites.exists?(post_id: post.id)
   end


# 年齢セレクトボックス
   enum age: { ones:1, two:2, trees:3, fours:4, fives:5, sixs:6, sevens:7, eightas:8 }

end
