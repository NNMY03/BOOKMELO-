class Home < ApplicationRecord
  
  validates :attention, acceptance: true, on: :create

end
