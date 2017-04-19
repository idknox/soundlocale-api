class AxsService < BaseService
  include EventUtils

  PER_PAGE = 500

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

  def base_uri
    'http://api.axs.com/v1/events'
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

  def self.per_page
    PER_PAGE
  end
end
