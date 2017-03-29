namespace :events do

  desc "Import events from Songkick"
  task sk: :environment do
    count = 0
    events = SongkickService.new.all
    events = events.map { |event| SongkickDataMapper.new(event).mapped_event }
    events.each do |event|
      ActiveRecord::Base.transaction do
        event = Event.find_or_initialize_by(event)
        unless event.persisted?
          event.save!
          count +=1
        end
      end
    end

    puts '*'*80
    puts "#{count} NEW EVENTS PULLED FROM SONGKICK"
    puts '*'*80
  end
end
