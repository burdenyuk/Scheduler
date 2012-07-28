class CalendarController < ApplicationController
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @slug = params[:slug]

    @shown_month = Date.civil(@year, @month)
    # @event_strips = Event.event_strips_for_month(@shown_month)
    @event_strips = Event.make_user_schedule(@year, @month, @slug)
  end

  def day
    
  end
end
