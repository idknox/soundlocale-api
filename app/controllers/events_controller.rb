class EventsController < ApplicationController
  def index
    events = Event.all.order(:starts_at).page(params[:page] || 1).per(50)
    render json: events
  end
end