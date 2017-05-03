class Api::EventsController < ApplicationController
  def index
    beginning = Date.strptime(params[:date], '%Y-%m-%d')
    events = Event.occurring_on(beginning).order(:starts_at)
    render json: events
  end
end