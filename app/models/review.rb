class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :song

  validates :rating, numericality: {minimum: 1, maximum: 5}
  validate :comment_only_once

  before_create :comment_only_once

  def comment_only_once
    if Review.where(user_id: self.user, song_id: self.song).any?
      errors.add(:comment, "only once per song!")
    end
  end

end