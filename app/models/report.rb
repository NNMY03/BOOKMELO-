class Report < ApplicationRecord
  
# 通報機能
  belongs_to :customer
  belongs_to :post
  
# 対応ステータス
  eunm status: { waiting: 0, keep: 1, finish: 2 }

end
