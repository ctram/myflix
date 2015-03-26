class ChangeQueuesToMyQueues < ActiveRecord::Migration
  def change
    rename_table(:queues, :my_queues)
  end
end
