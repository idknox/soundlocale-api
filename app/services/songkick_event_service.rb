class SongkickEventService < BaseService

  def initialize
    @events = []
  end

  PER_PAGE = 50

  def all_events
    fetch_events
    @events
  end

  def fetch_events
    response = get

    if response.code == 200
      @total_results ||= response['resultsPage']['totalEntries']
      @events += response['resultsPage']['results']['event']
      @page = response['resultsPage']['page'] + 1
    end

    fetch_events if @page <= total_pages
  end

  # def all
  #   total_pages.times.map.with_object([]) do |page, events|
  #     @uri = build_uri(page+1)
  #     events << get['resultsPage']['results']['event']
  #   end.flatten
  # end

  private

  def uri
    "#{base_uri}?#{stringified_options}"
  end

  def base_uri
    "http://api.songkick.com/api/3.0/metro_areas/#{ENV['SONGKICK_DENVER_METRO_ID']}/calendar.json"
  end

  def stringified_options
    opt_string_pairs = denver_opts.map { |k, v| "#{k}=#{v}" }
    opt_string_pairs.join('&')
  end

  def denver_opts
    {
      apikey: ENV['SONGKICK_API_KEY'],
      page: page
    }
  end

  def page
    @page ||= 1
  end

  def total_pages
    @pages ||= (@total_results / PER_PAGE) + 1
  end
end