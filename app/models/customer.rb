class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
# 年齢セレクトボックス
   enum age: {'10代':1, '20代':2, '30代':3, '40代':4, '50代':5, '60代':6, '70代':7, '80代':8 }
end
