class Song < ActiveRecord::Base

  belongs_to :user

  validates :song_title, presence: true
  validates :artist, presence: true
  validates :author, presence: true
  validates :url, presence: true
  validates :genre, presence: true

end