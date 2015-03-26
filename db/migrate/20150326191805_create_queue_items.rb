class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.integer :queue_id
      t.integer :video_id
      t.integer :position
      t.integer :rating
    end
  end
end
