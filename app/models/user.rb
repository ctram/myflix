class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews
  has_one :my_queue

  validates :name_first, presence:true
  validates :name_last, presence:true
  validates :email, presence: true, uniqueness:true
  validates :password, presence:true
end
