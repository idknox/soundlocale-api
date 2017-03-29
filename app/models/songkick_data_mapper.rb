class SongkickDataMapper
  def initialize(songkick_data)
    @data = songkick_data
  end

  def mapped_event
    {
      name: data['displayName'],
      headliner_name: data['performance'].first&.dig('artist', 'displayName'),
      opener_name: data['performance'][1]&.dig('artist', 'displayName'),
      description: "Ages: #{data['ageRestriction'] || 'All'}",
      venue_name: data['venue']['displayName'],
      venue_id: data['venue']['id'],
      starts_at: data['start']['datetime'] || data['start']['date'],
      tickets: data['uri'],
      vendor_id: data['id'],
      vendor_url: data['uri']
    }
  end

  private

  attr_reader :data
end