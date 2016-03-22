class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :song_title
      t.string :artist
      t.string :author
      t.string :url
      t.integer :likes, default: 0
      t.timestamps
    end
  end
end
