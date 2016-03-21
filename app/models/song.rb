class Song < ActiveRecord::Base

  validates :song_title, presence: true
  validates :artist, presence: true
  validates :author, presence: true
  validates :url, presence: true

end