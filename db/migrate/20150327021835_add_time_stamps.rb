class AddTimeStamps < ActiveRecord::Migration
  def change
    add_column :queue_items, :created_at, :datetime
    add_column :queue_items, :updated_at, :datetime
  end
end
