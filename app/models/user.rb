class User < ActiveRecord::Base
  include Tokenable
  has_secure_password

  has_many :reviews
  has_many :queue_items, -> { order(:position) }
  has_many :invitations

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
    "#{name_first.capitalize + ' ' + name_last.capitalize}"
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def follow(another_user)
    following_relationships.create(leader: another_user) if can_follow?(another_user)
  end

  def can_follow?(another_user)
    !(follows?(another_user) || self == another_user)
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end
