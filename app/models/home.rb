class Home < ApplicationRecord
  
#  空文字の送信を許可しない（ 
  validates :attention, acceptance: true

end
