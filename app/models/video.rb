class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  has_many :queue_items

  validates :name, presence: true
  validates :description, presence:true

  # before_create :generate_token

  # returns an array of videos
  def self.search_by_title(term)
    matches = []
    Video.all.each do |video|
      matches << video if /#{term}/i =~ video.name
    end
    matches.sort_by{|video| video.name}
  end

  def average_rating
    if self.reviews.count == 0
      nil
    else
      num_reviews = self.reviews.count
      total_rating = self.reviews.reduce(0) do |m, review|
        m += review.rating
      end
      (total_rating.to_f/ num_reviews).round(1)
    end
  end

  # Alias title to name
  def title
    name
  end

  # def to_param
  #   token
  # end

  private

  # def generate_token
  #   token = SecureRandom.urlsafe_base64
  # end
end
