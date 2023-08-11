class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
 has_many :posts, dependent: :destroy
 has_many :books, through: :posts
  
  has_one_attached :image
  
  def get_profile_image(height, width)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end
 

# 年齢セレクトボックス
   enum age: {'10代':1, '20代':2, '30代':3, '40代':4, '50代':5, '60代':6, '70代':7, '80代':8 }
   
  # お気に入り機能アソシエーション
   has_many :favorites, dependent: :destroy
   
end
