class DropMyQueuesAndModifyQueueItems < ActiveRecord::Migration
  def change
    drop_table :my_queues
    add_column :queue_items, :user_id, :integer
  end
end
