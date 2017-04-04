class Event < ApplicationRecord

  before_save :set_youtube_video_id

  def set_youtube_video_id
    self[:youtube_video_id] = YoutubeService.new.fetch_video_id(self)
  end
end
