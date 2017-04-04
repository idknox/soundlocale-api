class YoutubeService

  def initialize
    @videos = Yt::Collections::Videos.new
  end

  def fetch_video_id(event)
    results = search(event.headliner_name)
    results.first&.id
  end

  def search(query)
    @videos.where(q: "#{query} music", max_results: 1, order: 'viewCount')
  end
end