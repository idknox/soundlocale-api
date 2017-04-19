class SongkickService < BaseService
  include EventUtils

  PER_PAGE = 50

  def fetch_events
    response = get

    if response.code == 200
      @total_results ||= response['resultsPage']['totalEntries']
      @events += response['resultsPage']['results']['event']
      @page = response['resultsPage']['page'] + 1
    end

    fetch_events if @page <= total_pages
  end

  private

  def base_uri
    "http://api.songkick.com/api/3.0/metro_areas/#{ENV['SONGKICK_DENVER_METRO_ID']}/calendar.json"
  end

  def denver_opts
    {
      apikey: ENV['SONGKICK_API_KEY'],
      page: page
    }
  end

  def self.per_page
    PER_PAGE
  end
end