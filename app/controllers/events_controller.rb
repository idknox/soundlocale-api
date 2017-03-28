class EventsController < ApplicationController
  def index
    events = Event.all
    render json: events, root: :data
  end
end