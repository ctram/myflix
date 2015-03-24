class Video < ActiveRecord::Base
  belongs_to :category

  has_many :ratings
  has_many :reviews

  validates :name, presence: true
  validates :description, presence:true

  # returns an array of videos
  def self.search_by_title term
    matches = []
    Video.all.each do |video|
      matches << video if /#{term}/i =~ video.name
    end
    matches.sort_by{|video| video.name}
  end
end
