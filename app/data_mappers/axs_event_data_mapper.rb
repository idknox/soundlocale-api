class AxsEventDataMapper
  include DataMapperUtils

  def mapped_event

    {
      name: data['title']['eventTitleText'],
      headliner_name: data['associations']['headliners'].first&.dig('name'),
      opener_name: data['associations']['supportingActs'].map {|a| a['name']}.join('& '),
      description: "Ages: #{data['age'] || 'All'}",
      venue_name: data['venue']['title'],
      venue_id: data['venue']['venueId'],
      starts_at: data['eventDataTimeISO'],
      tickets: data['ticketing']['url'],
      vendor_id: data['eventId'],
      vendor_url: data['ticketing']['eventUrl']
    }
  end
end