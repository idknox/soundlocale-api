module EventUtils
  def initialize
    @events = []
  end

  def all_events
    fetch_events
    @events
  end

  private

  def uri
    "#{base_uri}?#{stringified_options}"
  end

  def stringified_options
    opt_string_pairs = denver_opts.map { |k, v| "#{k}=#{v}" }
    opt_string_pairs.join('&')
  end

  def page
    @page ||= 1
  end

  def total_pages
    @pages ||= (@total_results / self.class.per_page) + 1
  end

  def base_uri
    raise NotImplementedError
  end

  def denver_ops
    raise NotImplementedError
  end

  def self.per_page
    raise NotImplementedError
  end
end