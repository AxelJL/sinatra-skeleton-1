class Upvote < ActiveRecord::Base

  belongs_to :user
  belongs_to :song

  validate :upvote_only_once

  after_create :add_like_to_song

  def upvote_only_once
    if Upvote.where(user_id: self.user, song_id: self.song).any?
      errors.add(:upvote, "only once per song!")
    end
  end

  def add_like_to_song
    song.likes += 1
    song.save
  end

end