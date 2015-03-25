class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :user_id
      t.integer :video_id
      t.integer :rating_id
      t.timestamps
    end
  end
end
