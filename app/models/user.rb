class User < ActiveRecord::Base
  has_secure_password

  validates :name_first, presence:true
  validates :name_Last, presence:true
  validates :name_Last, presence:true
  validates :password, presence:true
end
