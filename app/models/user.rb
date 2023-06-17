class User < ApplicationRecord
  validates :phone_number, presence: true, 
                         format: { with: /\A\d+\z/, message: "must be a number." }, 
                         length: { is: 10 }
end
