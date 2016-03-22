class AddLikesAndDislikes < ActiveRecord::Migration
  def change
    add_column :songs, :likes, :integer, default: 0
    add_column :songs, :dislikes, :integer, default: 0
  end
end
