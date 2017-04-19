class AxsService < BaseService

  def initialize
    @events = []
  end

  PER_PAGE = 500

  def all_events
    fetch_events
    @events
  end

  def fetch_events
    response = get

    if response.code == 200
      @total_results ||= response['meta']['total']
      @events += response['events']
      @page = response['meta']['page'] + 1
    end

    fetch_events if @page <= total_pages
  end

  private

  def uri
    "#{base_uri}?#{stringified_options}"
  end

  def base_uri
    'http://api.axs.com/v1/events'
  end

  def stringified_options
    opt_string_pairs = denver_opts.map { |k, v| "#{k}=#{v}" }
    opt_string_pairs.join('&')
  end

  def denver_opts
    {
      access_token: ENV['AXS_TOKEN'],
      siteId: 1,
      lat: 39.740009,
      long: -104.992302,
      radius: 100,
      rows: PER_PAGE,
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
