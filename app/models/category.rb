class Category < ActiveRecord::Base
  has_many :videos, -> { order('name')}

  validates_presence_of :name

  def recent_videos
    self.videos.sort_by{|video| video.created_at}.reverse.slice(0,6)
  end
end
