class AddGenre < ActiveRecord::Migration
  def change
    add_column :songs, :genre, :string
  end
end
