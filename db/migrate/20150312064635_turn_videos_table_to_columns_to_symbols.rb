class TurnVideosTableToColumnsToSymbols < ActiveRecord::Migration
  def change
    drop_table :tests

    create_table :tests do |t|
      t.string :name
      t.text :description
      t.string :cover_small_url
      t.string :cover_large_url
      t.datetime :created_at
      t.datetime :updated_at
    end

  end
end
