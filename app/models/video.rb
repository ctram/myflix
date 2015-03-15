class Video < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true
  validates :description, presence:true

  def self.search_by_title term
    matches = []
    Videos.all.each do |video|
    end
  end

end
