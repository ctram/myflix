class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string "name"
      t.text "description"
      t.string "cover_small_url"
      t.string "cover_large_url"
    end
  end
end
