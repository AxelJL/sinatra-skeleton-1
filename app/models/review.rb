class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :song

  validate :comment_only_once

  before_create :comment_only_once

  def comment_only_once
    if Review.where(user_id: self.user, song_id: self.song).any?
      errors.add(:comment, "only once per song!")
    end
  end

end