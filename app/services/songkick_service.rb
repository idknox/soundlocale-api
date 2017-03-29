class SongkickService

  PER_PAGE = 50

  def initialize
    @info = HTTParty.get(build_url)['resultsPage']
  end

  def all
    page_count.times.map.with_object([]) do |page, events|
      url = build_url(page+1)
      data = HTTParty.get(url)
      events << data['resultsPage']['results']['event']
    end.flatten
  end

  private

  def build_url(page=1)
    "http://api.songkick.com/api/3.0/metro_areas/6404/calendar.json?apikey=#{ENV['SONGKICK_API_KEY']}&page=#{page}"
  end

  def page_count
    (total_results / PER_PAGE) + 1
  end

  def total_results
    @total ||= @info['totalEntries']
  end
end