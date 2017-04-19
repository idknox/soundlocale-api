namespace :events do
  desc "Import events from Songkick"
  task sk: :environment do
    normalizer = EventDataCollector.new(:songkick)
    normalizer.run
  end

  desc 'Import events from AXS'
  task axs: :environment do
    normalizer = EventDataCollector.new(:axs)
    normalizer.run
  end
end
