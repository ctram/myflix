class DropColumnOfQueueItems < ActiveRecord::Migration
  def change
    remove_column :queue_items, :my_queue_id
  end
end
