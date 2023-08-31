class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  validates :name, uniqueness: true
  validates :age, presence: true
  validates :gender, presence: true
 
# 楽天API中間テーブル 
 has_many :posts, dependent: :destroy
 has_many :books, through: :posts
 
# お気に入り機能アソシエーション
 has_many :favorites, dependent: :destroy
 
# 通報機能
  has_many :reports, dependent: :destroy
  
  # 退会済みユーザーをはじく 
 def active_for_authentication?
  super && (self.is_deleted == false)
 end
  
# customer　image画面
 has_one_attached :image
 
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
 
 # ゲストログイン
 GUEST_CUSTOMER_EMAIL = "guest@example.com"
 
def self.guest
  find_or_create_by!(email: GUEST_CUSTOMER_EMAIL) do |customer|
    customer.password = SecureRandom.urlsafe_base64
    customer.name = "ゲスト"
    customer.age = 2
    customer.gender = 2
  end
end

def guest_user?
  email == GUEST_CUSTOMER_EMAIL
end

# 年齢セレクトボックス
enum age: { ones:0, twos:1, trees:2, fours:3, fives:4, sixs:5, sevens:6, eightas:7 }
   
# 性別ラジオボタン
enum gender: { gender_male: 0, gender_female: 1, gender_normal: 2 }

end
