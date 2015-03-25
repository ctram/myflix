class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :video_id
      t.integer :user_id
      t.integer :review_id
      t.timestamps
    end
  end
end
