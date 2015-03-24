class RemoveRatingsTable < ActiveRecord::Migration
  def change
    drop_table :ratings
    rename_column :reviews, :rating_id, :rating
  end

end
