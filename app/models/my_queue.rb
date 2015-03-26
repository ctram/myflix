class MyQueue < ActiveRecord::Base
  belongs_to :user
  has_many :queue_items

end
