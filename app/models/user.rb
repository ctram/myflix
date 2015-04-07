class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews
  has_many :queue_items, -> { order(:position) }

  # A user has many relationships where he is the follower.
  # Since User calls has_many(), the foreign key is located
  # in the associated object (Relationship), not within User.
  has_many :following_relationships,
            class_name: 'Relationship',
            foreign_key: :follower_id

  # A user has many relationships where he is the leader.
  # Since User calls has_many(), the foreign key is located
  # in the associated object (Relationship), not within User.
  has_many :leading_relationships,
            class_name: 'Relationship',
            foreign_key: :leader_id

  validates :name_first, presence:true
  validates :name_last, presence:true
  validates :email, presence: true, uniqueness:true
  validates :password, presence:true



  def full_name
    "#{name_first + ' ' + name_last}"
  end
end
