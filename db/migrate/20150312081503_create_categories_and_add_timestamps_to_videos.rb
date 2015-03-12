class CreateCategoriesAndAddTimestampsToVideos < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    add_column :videos, :created_at, :datetime
    add_column :videos, :updated_at, :datetime
    add_column :videos, :category_id, :integer
  end
end
