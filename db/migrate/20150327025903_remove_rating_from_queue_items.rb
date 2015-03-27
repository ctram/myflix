class RemoveRatingFromQueueItems < ActiveRecord::Migration
  def change
    remove_column :queue_items, :rating
  end
end
