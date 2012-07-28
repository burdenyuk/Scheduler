class Event < ActiveRecord::Base
  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  belongs_to :user

  has_event_calendar

  def self.make_user_schedule(year, month, slug)
    events = someone_events(slug)
    events_days = Hash.new
    result = Array.new
    events.each do |ev|
      events_days[Integer(ev.start_at.to_s[8, 2])] = ev
    end
    36.times do |i|
      (events_days[i + 1].nil?) ? result << nil : result << events_days[i + 1]
    end
    Array.new.push(result)
  end

  private

  def self.days_in_month(month, year = Time.now.year)
    return 29 if month == 2 && Date.gregorian_leap?(year)
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end

  def self.someone_events(slug)
    current_user = User.find_by_slug(slug) || (raise ActionController::RoutingError.new('Not Found'))
    Event.where('user_id = ?', current_user.id)
  end

end
