class Event < ApplicationRecord

  validates_uniqueness_of :vendor_id

  scope :occurring_on, -> (date) { where('starts_at > ? AND starts_at < ?', date.beginning_of_day, date.end_of_day) }

  before_save :set_youtube_video_id

  def set_youtube_video_id
    self[:youtube_video_id] = YoutubeService.new.fetch_video_id(self)
  end
end
