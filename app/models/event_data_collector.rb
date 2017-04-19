class EventDataCollector
  VENDORS = {
    axs: {
      service: 'AxsService',
      data_mapper: '::AxsEventDataMapper',
      name: 'AXS'
    },
    songkick: {
      service: 'SongkickService',
      data_mapper: '::SongkickEventDataMapper',
      name: 'SONGKICK'
    }
  }.freeze

  def initialize(vendor)
    @vendor = VENDORS[vendor]
    @count = 0
  end

  def run
    fetch_events
    save_events
    print_count
  end

  private

  attr_reader :vendor

  def fetch_events
    events = vendor[:service].constantize.new.all_events
    @events = events.map { |event| vendor[:data_mapper].constantize.new(event).mapped_event }
  end

  def save_events
    ActiveRecord::Base.transaction do
      @events.each do |event_data|
        event = Event.exists?(vendor_id: event_data[:vendor_id])
        unless event.present?
          Event.create!(event_data)
          @count +=1
        end
      end
    end
  end

  def print_count
    puts '*'*80
    puts "#{@count} NEW EVENTS PULLED FROM #{vendor[:name]}"
    puts '*'*80
  end
end