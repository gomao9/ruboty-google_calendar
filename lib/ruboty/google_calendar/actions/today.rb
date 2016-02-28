require 'ruboty'
module Ruboty::GoogleCalendar::Actions
  class Today < Ruboty::Actions::Base
    HHMM_FORMAT = "%H:%M"
    ALLDAY      = "終日 "
    def call
      message.reply(today)
    rescue => e
      message.reply(e.message + "\n" + e.backtrace.join("\n"))
    end

    private

    def today
      day = if message[:date]
              year, month, day = message[:date].scan(/(\d{4})(\d{2})(\d{2})/).first
              Time.new(year, month, day)
            else
              Time.now
            end

      ids = ENV['GOOGLE_CALENDAR_IDS'].split(',')
      client = Ruboty::GoogleCalendar::CalendarClient.new ENV
      ids.flat_map{|id| client.search(id, day)}.uniq(&:id).map do |event|
        time = if event.start.date_time
                 time_format(event.start.date_time, event.end.date_time)
               else
                 ALLDAY
               end
        atendees = event.attendees.map(&:display_name).join(',')

        sprintf("%s[%s]:%s", time, atendees, event.summary)
      end.join("\n")
    end

    def time_format st, ed
      "#{st.strftime(HHMM_FORMAT)}〜#{ed.strftime(HHMM_FORMAT)}"
    end

  end
end
