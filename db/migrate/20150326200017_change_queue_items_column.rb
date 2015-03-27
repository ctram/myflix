class ChangeQueueItemsColumn < ActiveRecord::Migration
  def change
    rename_column(:queue_items, :queue_id, :my_queue_id)
  end
end
