class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :review
      t.references :user
      t.references :song
      t.timestamps
    end
  end
end
