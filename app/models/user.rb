class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews
  has_many :queue_items, -> { order(:position) }
  has_many :following_relationships,
            class_name: 'Relationship',
            foreign_key: :follower_id

  validates :name_first, presence:true
  validates :name_last, presence:true
  validates :email, presence: true, uniqueness:true
  validates :password, presence:true



  def full_name
    "#{name_first + ' ' + name_last}"
  end
end
